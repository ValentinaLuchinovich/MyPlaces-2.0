//
//  TabBarController.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var handleTabSelection: (Int)->Void = {_ in}
    
    var selectIndex: Int = 0 {
        didSet {
            handleTabSelection(selectIndex)
        }
    }
    
    private lazy var mapBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-26, y: -20, width: 52, height: 52))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        self.delegate = self
        setupQrButton()
    }
    
#warning("Сейчас верзня чвсть красной кнопки не работает")
    
    //Добавляет действия нажатия кнопки при попадании в зону tabBar.item
    func qrButtonIsSelected() {
        mapBtn.sendActions(for: .touchUpInside)
    }
}

// MARK: - Private

private extension TabBarController {
    
    func setupQrButton() {
        mapBtn.backgroundColor = .lightText
        mapBtn.setImage( UIImage(systemName: "globe.europe.africa.fill"), for: .normal)
        mapBtn.contentMode = .scaleToFill
        mapBtn.layer.cornerRadius = (mapBtn.layer.frame.width / 2)
        self.tabBar.addSubview(mapBtn)
        mapBtn.layer.removeAllAnimations()
        mapBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction() {
        let coordinator = MapTabCoordinator(NavigationController())
        coordinator.parentNavigationController = navigationController as? NavigationController
        coordinator.start()
    }
}
