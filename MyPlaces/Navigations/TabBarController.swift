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
    
    private lazy var qrBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-26, y: -20, width: 52, height: 52))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        self.delegate = self
        setupQrButton()
    }
    
    //Добавляет действия нажатия кнопки при попадании в зону tabBar.item
    func qrButtonIsSelected() {
        qrBtn.sendActions(for: .touchUpInside)
    }
}

// MARK: - Private

private extension TabBarController {
    
    func setupQrButton() {
        qrBtn.setImage(UIImage(named: "qr"), for: .normal)
        qrBtn.setImage(UIImage(named: "qr"), for: .highlighted)
        qrBtn.contentMode = .scaleToFill
        qrBtn.layer.cornerRadius = (qrBtn.layer.frame.width / 2)
        self.tabBar.addSubview(qrBtn)
        qrBtn.layer.removeAllAnimations()
        qrBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction() {
        let coordinator = QRCodeTabCoordinator(NavigationController())
        coordinator.parentNavigationController = navigationController as? NavigationController
        coordinator.start()
    }
}
