//
//  MapCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 05.03.2025.
//

import UIKit

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
        return MapViewController()
//        BackgroundViewController(VisitsFactory().build(coordinator: self), navigationController: navigationController)
    }
}

extension MapCoordinator {
    
//    func showClientDetailsScreen(_ viewModel: VisitsViewModel) {
//        let vc = VisitsClientDetailViewController(viewModel)
//        navigationController.presentFpc(vc, animated: true, scrollView: vc.tableView, haveGrabber: true , layout: .fullScreen(20))
//    }
//    
//    func showModal(delegate: PushDelegate?) {
//        let viewController = PushTurnOnModalViewController(delegate: delegate)
//        navigationController.presentFpc(viewController, animated: true, layout: .autoSized())
//    }
//    
//    #warning("Используется для переходов по deeplink, если будет не нужно - удалить")
//    func showAnalytic() {
//        (navigationController.tabBarController as? TabBarController)?.tabBarButtonAction(selectedIndex: 1)
//    }
}
