//
//  UIButton + setImage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 18.03.2025.
//

import UIKit

public extension UIButton {
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }
    
}
