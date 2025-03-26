//
//  CountryTableViewCell.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 18.03.2025.
//

import UIKit

/// Ячейка с флагом
final class CountryTableViewCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        public static let iconImageViewSize = 24.0
    }
    
    // MARK: Internal properties
    
    static let cellID = "countryTableViewCell"
    var isVisited: Bool = false
    
    // MARK: Private properties
    
    private lazy var containerView = UIView()
    
    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
        
    private lazy var titleLabel: Label = {
        let label = Label(font: .base(.medium))
        label.text = "Название страны"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var checkboxButton: UIButton = {
        let button = CheckboxButton()
        button.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ model: CountryModel) {
        flagImageView.downloadImage(urlString: model.flags.png)
        titleLabel.text = model.name.common
    }
}

// MARK: Actions

@objc
private extension CountryTableViewCell {
    
    func didTapCheckbox() {
        checkboxButton.isSelected.toggle()
    }
}

// MARK: Internal methods

private extension CountryTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        configureLayout()
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(flagImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(checkboxButton)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        flagImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.iconImageViewSize)
            make.verticalEdges.leading.equalToSuperview().inset(AppConstants.mediumPadding)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(AppConstants.mediumPadding)
            make.centerY.equalToSuperview()
        }
        
        checkboxButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(AppConstants.mediumPadding)
            make.trailing.equalToSuperview().inset(AppConstants.mediumPadding)
        }
    }
}
