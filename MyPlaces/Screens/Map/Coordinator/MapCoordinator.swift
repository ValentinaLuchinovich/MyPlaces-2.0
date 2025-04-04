//
//  MapCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 05.03.2025.
//

import UIKit
import SwiftUI

final class MapCoordinator: Coordinator {
    
    // MARK: Initialization
    
    deinit {
        print("VisitsCoordinator удален")
    }
}

// MARK: TabBarChildCoordinated

extension MapCoordinator: TabBarChildCoordinated {
    
    public func makeTab() -> UIViewController {
#warning("Переделать на фабрику")
        return UIHostingController(rootView: MapView())
//        BackgroundViewController(VisitsFactory().build(coordinator: self), navigationController: navigationController)
    }
}
