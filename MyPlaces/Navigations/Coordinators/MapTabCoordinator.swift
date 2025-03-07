//
//  MapTabCoordinator.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

final class MapTabCoordinator {

    // MARK: Protocol properties
    
    var childCoordinators = [TabBarChildCoordinated]()
    var navigationController: NavigationController
    weak var parentNavigationController: NavigationController?
    
    // MARK: Private properties
    
    private var isBonus = true
    private var updateProfile: (() -> ())?
    
    // MARK: Initialization
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("MapTabCoordinator deinit")
    }
    
    func start() {
        #warning("Заменить на карту, а не на бонусную")
        showDetailBonusCard()
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: Private

private extension MapTabCoordinator {
    
    private func showDetailBonusCard() {
//        let contentVC = DetailBonusCardViewController()
//        fpc = showModal(contentVC: contentVC, parentVC: parentNavigationController, withGrabber: true, layout: FloatingPanelLayoutFullScreen(with: 8))
//        fpc.contentMode = .static
//        fpc.followScrollViewBouncing()
//        fpc.track(scrollView: contentVC.scrollView)
    }
}
