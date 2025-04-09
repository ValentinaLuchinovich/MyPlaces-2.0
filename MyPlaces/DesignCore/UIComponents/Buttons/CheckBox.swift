//
//  CheckBox.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 18.03.2025.
//

import UIKit
import SnapKit

/// Кнопка-чекбокс
final class CheckboxButton: UIButton {
    
    // MARK: Constants
    
    private enum Constants {
        static let visualSize = CGSize(width: 20, height: 20)
        static let touchTargetSize = CGSize(width: 44, height: 44) // Standard iOS touch target size
    }
    
    // MARK: Public properties

    override var isSelected: Bool {
        didSet {
            setupImage()
        }
    }
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public methods

extension CheckboxButton {
    
    func toggle() {
        isSelected = !isSelected
    }
}

// MARK: Private methods

private extension CheckboxButton {

    func setupUI() {
        setupImage()
        snp.makeConstraints { make in
            make.size.equalTo(Constants.touchTargetSize)
        }
    }
    
    func setupImage() {
        let checkboxImage = Assets.Images.checkbox.image.withRenderingMode(.alwaysTemplate)
        
        let selectedCheckboxImage = Assets.Images.checkboxSelected.image.withRenderingMode(.alwaysTemplate)
        
        let image = isSelected
        ? selectedCheckboxImage
        : checkboxImage
       
        setImage(image.resizeImage(Constants.visualSize))
    }
}
