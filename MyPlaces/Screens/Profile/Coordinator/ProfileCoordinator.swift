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
#warning("Переделать на фабрику")
//        BackgroundViewController(VisitsFactory().build(coordinator: self), navigationController: navigationController)
        return ProfileViewController()
    }
}

extension ProfileCoordinator {
    
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
