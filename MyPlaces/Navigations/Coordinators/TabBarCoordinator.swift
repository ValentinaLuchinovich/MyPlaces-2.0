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
    
    public typealias Screen = TabBarPage
    
    public func start(with screen: TabBarPage) {
        let controllers: [UIViewController] = childCoordinators.map { $0.makeTab() }
        tabBar.setViewControllers(controllers, animated: true)
        navigationController.pushViewController(tabBar, animated: true)
    }
    
    public func clearChilds() {
        super.clear()
        childCoordinators.forEach { $0.backToRootWithDismiss() }
        childCoordinators = []
    }
}
