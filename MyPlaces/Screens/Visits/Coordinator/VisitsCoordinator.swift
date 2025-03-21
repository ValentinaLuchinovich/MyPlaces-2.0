//
//  VisitsCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 05.03.2025.
//

import UIKit

final class VisitsCoordinator: Coordinator {
    
    // MARK: Initialization
    
    deinit {
        print("VisitsCoordinator удален")
    }
}

// MARK: TabBarChildCoordinated

extension VisitsCoordinator: TabBarChildCoordinated {
    
    public func makeTab() -> UIViewController {
        VisitsFactory().build(coordinator: self)
    }
}
