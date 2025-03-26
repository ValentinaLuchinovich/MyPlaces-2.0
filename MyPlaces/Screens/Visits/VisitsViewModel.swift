//
//  VisitsViewModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 21.03.2025.
//

import Combine

final class VisitsViewModel {
    
    // MARK: Private properties
    
    private var coordinator: VisitsCoordinator
    private var visitsRepository: VisitsRepositoryProtocol
    
    // MARK: Internal properties
    
    @Published var countries: [CountryModel] = []
    
    // MARK: Initialization
    
    init(coordinator: VisitsCoordinator, visitsRepository: VisitsRepositoryProtocol) {
        self.coordinator = coordinator
        self.visitsRepository = visitsRepository
        
        getCountries()
    }
}

// MARK: Private methods

private extension VisitsViewModel {
    func getCountries() {
        Task {
            do {
                countries = try await self.visitsRepository.getAllCountries()
            }
        }
    }
}

