//
//  Fonts.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

enum FontGeometriaType: String {
    case regular = "Geometria"
    case medium = "Geometria-Medium"
    case bold = "Geometria-Bold"
}

enum GeometriaFont {
    ///10 px / line spacing 12px
    case extraSmall(FontGeometriaType)
    ///12 px / line spacing 16px
    case small(FontGeometriaType)
    ///14 px / line spacing 20px
    case medium(FontGeometriaType)
    ///16 px / line spacing 24px
    case base(FontGeometriaType)
    ///18 px / line spacing 28px
    case large(FontGeometriaType)
    ///20 px / line spacing 28px
    case extraLarge(FontGeometriaType)
    ///24 px / line spacing 32px
    case huge(FontGeometriaType)
    ///30 px/ line spacing 36
    case extraHuge(FontGeometriaType)
    
    var font: UIFont {
        switch self {
            case .extraSmall(let wight):
                UIFont(name: wight.rawValue, size: 10)!
            case .small(let wight):
                UIFont(name: wight.rawValue, size: 12)!
            case .medium(let wight):
                UIFont(name: wight.rawValue, size: 14)!
            case .base(let wight):
                UIFont(name: wight.rawValue, size: 16)!
            case .large(let wight):
                UIFont(name: wight.rawValue, size: 18)!
            case .extraLarge(let wight):
                UIFont(name: wight.rawValue, size: 20)!
            case .huge(let wight):
                UIFont(name: wight.rawValue, size: 24)!
            case .extraHuge(let wight):
                UIFont(name: wight.rawValue, size: 30)!
        }
    }
    
    var lineSpacing: CGFloat {
        switch self {
            case .extraSmall:
                12
            case .small:
                16
            case .medium:
                20
            case .base:
                24
            case .large, .extraLarge:
                28
            case .huge:
                32
            case .extraHuge:
                36
        }
    }
}
