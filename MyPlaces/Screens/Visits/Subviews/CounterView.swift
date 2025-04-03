//
//  CounterView.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 01.04.2025.
//

import SnapKit
import UIKit

final class CounterView: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let width = 60
    }
    
    // MARK: Internal properties
    
    /// прогресс от 0 до 100
    var progress: Int = 0 {
        didSet {
            currentProgressLabel.text = AppLocalizable.percent(progress)
            progressBar.progress = progress
        }
    }
    
    /// желаемый/максимальный прогресс строкой
    var maxProgress: String? {
        didSet {
            maxProgressLabel.text = maxProgress
        }
    }
    
    /// Количество стран
    var countriesCount: [Int: Int] = [0:0] {
        didSet {
            counterLabel.text = AppLocalizable.counter(countriesCount.keys.first!, countriesCount.values.first!)
        }
    }
    
    // MARK: Private properties
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = AppConstants.baseCornerRadius
        view.layer.borderWidth = AppConstants.tinyPadding
        view.layer.borderColor = UIColor.orangeDark.cgColor
        return view
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = GeometriaFont.huge(.regular).font
        label.textColor = .orangeDark
        label.textAlignment = .center
        return label
    }()
    
    private lazy var currentProgressLabel: UILabel = {
        let label = UILabel()
        label.font = GeometriaFont.small(.regular).font
        label.textColor = .black
        label.textAlignment = .left
        label.text = AppLocalizable.ProgressBar.maxProgress
        return label
    }()
    
    private lazy var maxProgressLabel: UILabel = {
        let label = UILabel()
        label.font = GeometriaFont.small(.regular).font
        label.textColor = Assets.Colors.grey.color
        label.textAlignment = .right
        label.text = AppLocalizable.ProgressBar.maxProgress
        return label
    }()
    
    private lazy var progressBar = CustomProgressBar()
    
    // MARK: Inititalization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
}

// MARK: Private methods

private extension CounterView {
    
    func setupUI() {
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(conteinerView)
        conteinerView.addSubview(counterLabel)
        conteinerView.addSubview(currentProgressLabel)
        conteinerView.addSubview(maxProgressLabel)
        conteinerView.addSubview(progressBar)
    }
    
    func configureLayout() {
        conteinerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(AppConstants.smallPadding)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(AppConstants.padding)
        }
        
        currentProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(counterLabel.snp.bottom).inset(AppConstants.extraLargePadding)
            make.leading.equalToSuperview().inset(AppConstants.padding)
            make.width.greaterThanOrEqualTo(Constants.width)
        }
        
        maxProgressLabel.snp.makeConstraints { make in
            make.top.equalTo(currentProgressLabel.snp.top)
            make.width.greaterThanOrEqualTo(Constants.width)
            make.trailing.equalToSuperview().inset(AppConstants.padding)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(currentProgressLabel.snp.bottom).offset(AppConstants.smallPadding)
            make.horizontalEdges.bottom.equalToSuperview().inset(AppConstants.padding)
        }
    }
}
