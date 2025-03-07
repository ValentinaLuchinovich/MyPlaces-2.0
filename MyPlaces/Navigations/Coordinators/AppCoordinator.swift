//
//  AppCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import Foundation

final class AppCoordinator: Coordinator {
    
    var tabBarCoordinator: TabBarCoordinator?
    
    func start() {
        let childCoordinators: [TabBarChildCoordinated] = [
            VisitsCoordinator(),
            MapCoordinator(),
            ProfileCoordinator()
        ]
        tabBarCoordinator = TabBarCoordinator(navigationController, with: childCoordinators)
        startChildCoordinator(tabBarCoordinator!)
    }
}

// MARK: Private methods

private extension AppCoordinator {
    
    func startChildCoordinator<ChildCoordinator: ChildCoordinated>(
        _ coordinator: ChildCoordinator
    ) {
        coordinator.start()
        clear()
    }
}
