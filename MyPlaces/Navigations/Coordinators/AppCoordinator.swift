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
        prepare()
//        self.startChildCoordinator(AuthCoordinator(self.navigationController, with: self), with: .auth)
    }
    
//    private var networkErrorScreen: NetworkErrorViewController?
    
    
    private func prepare() {
//        // Настройка показа экрана "Нет подключения к сети"
//        APIClient.shared.timeOutHandler = {
//            ErrorManager.shared.topViewController(errorViewController: NetworkErrorViewController())
//        }
//        NetworkMonitor.shared.startMonitoring()
//        NotificationCenter.default.addObserver(self, selector: #selector(showNetworkErrorScreen), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    @objc private func showNetworkErrorScreen() {
//        if !NetworkMonitor.shared.isConnected {
//            DispatchQueue.main.async {
//                let vc = NetworkErrorViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.navigationController.present(vc, animated: true)
//            }
//        }
    }
}

// MARK: ParentAuthCoordinated

//extension AppCoordinator: ParentAuthCoordinated {
//    
//    func showCreatePINCode() {
//        if LocalStorage.pinCode != nil {
//            success()
//        }
//        else {
//            let pincodeVC = PinCodeCoordinator(navigationController, with: self)
//            startChildCoordinator(pincodeVC, with: .createPincode)
//        }
//    }
//}



// MARK: Private methods

private extension AppCoordinator {
    
    func startChildCoordinator<ChildCoordinator: ChildCoordinated>(
        _ coordinator: ChildCoordinator,
        with screen: ChildCoordinator.Screen
    ) {
        coordinator.start(with: screen)
        clear()
    }
}
