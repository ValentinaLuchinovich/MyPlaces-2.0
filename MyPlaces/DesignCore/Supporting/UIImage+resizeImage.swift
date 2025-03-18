//
//  UIImage+resizeImage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 18.03.2025.
//

import UIKit

public extension UIImage {
    
    func resizeImage(_ targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return image
    }
}
