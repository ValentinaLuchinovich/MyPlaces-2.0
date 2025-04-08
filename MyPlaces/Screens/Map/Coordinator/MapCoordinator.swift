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
        return UIHostingController(rootView: MapView())
    }
}
