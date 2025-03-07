//
//  TabBarCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    // MARK: Private properties
    
    private lazy var tabBar = TabBarController()
    private var childCoordinators: [TabBarChildCoordinated] = []
    
    // MARK: Initialization
    
    public required init(
        _ navigationController: NavigationController,
        with childCoordinators: [TabBarChildCoordinated]
    ) {
        self.childCoordinators = childCoordinators
        super.init(navigationController)
    }
    
    required init(_ navigationController: NavigationController = NavigationController()) {
        fatalError("init(_:) has not been implemented")
    }
    
    // MARK: Initialization
    
    deinit {
        print("TabBarCoordinator удален")
    }
}

// MARK: ChildCoordinated

extension TabBarCoordinator: ChildCoordinated {
    
    public func start()  {
        let pages = TabBarPage.allCases
        let controllers: [UIViewController] = childCoordinators.enumerated().map { (index, element) in
            let controller = element.makeTab()
            controller.tabBarItem = UITabBarItem(title: nil, image: pages[index].icon?.withRenderingMode(.alwaysOriginal), tag: pages[index].pageNumber)
            controller.tabBarItem.selectedImage = pages[index].selectedIcon?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.title = pages[index].title
            return controller
        }
        tabBar.setViewControllers(controllers, animated: true)
        navigationController.pushViewController(tabBar, animated: true)
    }
}
