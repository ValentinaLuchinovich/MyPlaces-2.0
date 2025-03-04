//
//  TabBarPage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit
import SnapKit

enum TabBarPage: CaseIterable {
    case record, analitic, profile

    init?(index: Int) {
        switch index {
            case 0: self = .record
            case 1: self = .analitic
            case 2: self = .profile
            default: return nil
        }
    }
    
    var title: String {
        var title = ""
        switch self {
            case .record: title = "Записи"
            case .analitic: title = "Аналитика"
            case .profile: title = "Профиль"
        }
        return title
    }
    
    var pageNumber: Int {
        var num = 0
        switch self {
            case .record: num = 0
            case .analitic: num = 1
            case .profile: num = 2
        }
        return num
    }

    var icon: UIImage? {
        var icon: UIImage?
//        switch self {
//            case .record: icon = Assets.TabBar.categoryTab.image
//            case .analitic: icon = Assets.TabBar.graphTab.image
//            case .profile: icon = Assets.TabBar.profileTab.image
//        }
        return icon
    }
    
    var selectedIcon: UIImage? {
        var icon: UIImage?
//        switch self {
//            case .record: icon = Assets.TabBar.categoryFill.image
//            case .analitic: icon = Assets.TabBar.graphFill.image
//            case .profile: icon = Assets.TabBar.profileFill.image
//        }
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
    
    private var pageType: TabBarPage = .analitic
    private var buttonHandler: (Int)->() = {_ in}
    
    private lazy var image = UIImageView()
    
    private lazy var title = Label(font: GeometriaFont.small(.medium))
    
    private lazy var dot: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.dotSize / 2
//        view.backgroundColor = Assets.Colors.purple.color
        return view
    }()
    
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
//            title.textColor = Assets.Colors.purple.color
            image.image = pageType.selectedIcon
        } else {
//            title.textColor = Assets.Colors.grey.color
            image.image = pageType.icon
        }
        
        image.contentMode = .top
        dot.isHidden = !isSelected
    }
}

// MARK: Private methods

private extension TabBarButton {

    func setupUI() {
        addSubview(image)
        addSubview(title)
        addSubview(dot)
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
        
        dot.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(Constants.topPadding)
            make.size.equalTo(Constants.dotSize)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func buttonAction() {
        buttonHandler(pageType.pageNumber)
        setupView(isSelected: true)
    }
}
