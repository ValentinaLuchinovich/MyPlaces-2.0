//
//  CustomLoader.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 26.03.2025.
//

import UIKit

final class CustomLoader: UIActivityIndicatorView {
    
    // MARK: Constants
    
    private enum Constants {
        //28 px
        static let size = CGAffineTransform(scaleX: 1.4, y: 1.4)
    }
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        transform = Constants.size
    }
}


// MARK: Private methods

private extension CustomLoader {
    
    func setupUI() {
        color = Assets.Colors.orange.color
    }
}
