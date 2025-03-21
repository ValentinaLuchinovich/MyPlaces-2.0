//
//  VisitsViewModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 21.03.2025.
//

final class VisitsViewModel {
    
    // MARK: Private properties
    
    private var coordinator: VisitsCoordinator
    private var visitsRepository: VisitsRepositoryProtocol
    
    // MARK: Initialization
    
    init(coordinator: VisitsCoordinator, visitsRepository: VisitsRepositoryProtocol) {
        self.coordinator = coordinator
        self.visitsRepository = visitsRepository
    }
}
