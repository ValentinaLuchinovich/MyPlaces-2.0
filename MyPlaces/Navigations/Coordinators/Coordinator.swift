//
//  Coordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

class Coordinator {
    
    // MARK: Internal Properties
    
    let navigationController: NavigationController
    
    // MARK: Initialization
    
    required init(_ navigationController: NavigationController = NavigationController()) {
        self.navigationController = navigationController
    }
    
    open func back() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: Public methods

extension Coordinator {
    
    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func backToRootWithDismiss() {
        navigationController.dismiss(animated: true)
        backToRoot()
    }
    
    func clear() {
        if let lastViewController = navigationController.viewControllers.last {
            navigationController.viewControllers = [lastViewController]
        }
    }
}
