//
//  VisitsViewController.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 04.03.2025.
//

import UIKit
import Combine

/// Экран стрнан и посещенных мест
final class VisitsViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let headerHeight: CGFloat = 160
    }
    
    // MARK: Private properties
    
    private var cancellableSet = Set<AnyCancellable>()
    private let viewModel: VisitsViewModel
    
    let counterView = CounterView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.cellID)
        
        tableView.tableHeaderView = counterView
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: Constants.headerHeight)
        return tableView
    }()
    
    private lazy var loader = CustomLoader()
    
    // MARK: Initialization
    
    init(_ viewModel: VisitsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loader.startAnimating()
    }
}

// MARK: UITableViewDataSource

extension VisitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.cellID, for: indexPath
        ) as! CountryTableViewCell
        cell.configureCell(viewModel.countries[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate

extension VisitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}

// MARK: Private methods

private extension VisitsViewController {
    
    func setupUI() {
        bindings()
        configureLayout()
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        view.addSubview(loader)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(AppConstants.smallPadding)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bindings() {
        viewModel.$updateCountries
            .sink { [weak self] isDataLoaded in
                if isDataLoaded {
                    Task {
                        await MainActor.run {
                            self?.tableView.reloadData()
                            self?.loader.stopAnimating()
                            
                            self?.setupCounterView()
                        }
                    }
                }
            }
            .store(in: &cancellableSet)
    }
    
    func setupCounterView() {
        viewModel.updateCountriesList()
        
        let beenCount = viewModel.countries.filter{ $0.been }.count
        counterView.progress = viewModel.countries.count / 100 * beenCount
        counterView.countriesCount = [beenCount:viewModel.countries.count]
        counterView.setNeedsDisplay()
    }
}

// MARK: CountryTableViewCellDelegate

extension VisitsViewController: CountryTableViewCellDelegate {
    func updateCounterView() {
        setupCounterView()
    }
}
