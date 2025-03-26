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
    
    private lazy var mapBtnImage = UIImageView(image: UIImage(systemName: "globe.europe.africa.fill"))
    
    private lazy var mapBtn = UIView(frame: CGRect(x: (self.view.bounds.width / 2)-26, y: -2, width: 52, height: 52))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        self.delegate = self
        setupMapButton()
    }
}

// MARK: - Private

private extension TabBarController {
    
    func setupMapButton() {
        mapBtnImage.tintColor = .orange
        mapBtn.backgroundColor = .white
        mapBtn.layer.cornerRadius = (mapBtn.layer.frame.width / 2)
        
        mapBtn.addSubview(mapBtnImage)
        mapBtnImage.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        self.tabBar.addSubview(mapBtn)
    }
}
