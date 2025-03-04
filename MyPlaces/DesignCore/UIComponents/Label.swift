//
//  Label.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

/// Кастомный лейбл с не стандартной высотой строки
final class Label: UILabel {
    
    // MARK: Public properties
    
    var customFont: GeometriaFont {
        didSet {
            if text != nil {
                fontWithLineHeight(font: customFont)
            }
        }
    }
    
    // MARK: Initialization
    
    init(font: GeometriaFont) {
        self.customFont = font
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text: String? {
        didSet {
            if text != nil {
                fontWithLineHeight(font: customFont)
            }
        }
    }
    
    // MARK: Private methods
    
    private func fontWithLineHeight(font: GeometriaFont) {
        self.font = font.font
        var attributeStringInitial: NSMutableAttributedString?
        
        if let text_ = self.text {
            attributeStringInitial = NSMutableAttributedString(string: text_)
        } else if let text_ = self.attributedText {
            attributeStringInitial = NSMutableAttributedString(attributedString: text_)
        }
        
        guard let attributeString = attributeStringInitial else { return }
        
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = font.lineSpacing / font.font.pointSize
        style.maximumLineHeight = font.lineSpacing
        style.alignment = textAlignment
    
        var offset: CGFloat = 0
        
        if #available(iOS 16, *) {
            offset = (font.lineSpacing - font.font.pointSize) / 2
        } else {
            offset = (font.lineSpacing - font.font.pointSize) / 4
        }
        
        attributeString.addAttributes([
            NSAttributedString.Key.baselineOffset: offset,
            NSAttributedString.Key.paragraphStyle: style], range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
}
