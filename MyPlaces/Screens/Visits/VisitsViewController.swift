//
//  VisitsViewController.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 04.03.2025.
//

import UIKit

/// Экран стрнан и посещенных мест
final class VisitsViewController: UIViewController {
    
    // MARK: Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.cellID)
        return tableView
    }()

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: UITableViewDataSource

extension VisitsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.cellID, for: indexPath
        ) as! CountryTableViewCell
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(AppConstants.smallPadding)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func bindings() {
        
    }
}

