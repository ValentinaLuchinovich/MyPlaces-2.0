//
//  ProfileCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 05.03.2025.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    // MARK: Initialization
    
    deinit {
        print("VisitsCoordinator удален")
    }
}

// MARK: TabBarChildCoordinated

extension ProfileCoordinator: TabBarChildCoordinated {
    
    public func makeTab() -> UIViewController {
        return ProfileViewController()
    }
}
