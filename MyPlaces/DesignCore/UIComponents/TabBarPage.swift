//
//  TabBarPage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit
import SnapKit

enum TabBarPage: CaseIterable {
    case visits, map, profile

    init?(index: Int) {
        switch index {
        case 0: self = .visits
        case 1: self = .map
        case 2: self = .profile
            default: return nil
        }
    }
    
    var title: String {
        var title = ""
        switch self {
        case .visits: title = "Путешествия"
        case .map: title = "Карта"
        case .profile: title = "Аналитика"
        }
        return title
    }
    
    var pageNumber: Int {
        var num = 0
        switch self {
        case .visits: num = 0
        case .map: num = 1
        case .profile: num = 2
        }
        return num
    }

    var icon: UIImage? {
        var icon: UIImage?
        switch self {
        case .visits: icon = UIImage(systemName: "map")
        case .map: icon = UIImage(systemName: "globe.europe.africa")
        case .profile: icon = UIImage(systemName: "person")
        }
        return icon
    }
    
    var selectedIcon: UIImage? {
        var icon: UIImage?
        switch self {
        case .visits: icon = UIImage(systemName: "map.fill")
        case .map: icon = UIImage(systemName: "globe.europe.africa.fill")
        case .profile: icon = UIImage(systemName: "person.fill")
        }
        return icon
    }
}


/// Кастомная кнопка для таб бара
final class TabBarButton: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let dotSize = 4.0
        static let imageSize = 20.0
        static let topPadding = -2.0
    }
    
    // MARK: Private properties
    
    private var pageType: TabBarPage = .visits
    private var buttonHandler: (Int)->() = {_ in}
    
    private lazy var image = UIImageView()
    
    private lazy var title = Label(font: GeometriaFont.small(.medium))
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return btn
    }()
    
    // MARK: Initialization
    
    init(type: TabBarPage, buttonAction: @escaping (Int) -> ()) {
        super.init(frame: .zero)
        self.pageType = type
        self.buttonHandler = buttonAction
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Intrnal methods
 
extension TabBarButton {
    
    func setupView(isSelected: Bool) {
        title.text = pageType.title
        
        if isSelected {
            title.textColor = Assets.Colors.orange.color
            image.image = pageType.selectedIcon
        } else {
            title.textColor = Assets.Colors.grey.color
            image.image = pageType.icon
        }
    }
}

// MARK: Private methods

private extension TabBarButton {

    func setupUI() {
        addSubview(image)
        addSubview(title)
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AppConstants.padding)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.imageSize)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).inset(Constants.topPadding)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func buttonAction() {
        buttonHandler(pageType.pageNumber)
        setupView(isSelected: true)
    }
}
