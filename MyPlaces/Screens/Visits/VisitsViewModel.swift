//
//  VisitsViewModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 21.03.2025.
//

import Foundation
import Combine

final class VisitsViewModel {
    
    // MARK: Private properties
    
    private var coordinator: VisitsCoordinator
    private var visitsRepository: VisitsRepositoryProtocol
    
    // MARK: Internal properties
    
    var countries: [CountryModel] = []
    
    @Published var updateCountries: Bool = false
    
    // MARK: Initialization
    
    init(coordinator: VisitsCoordinator, visitsRepository: VisitsRepositoryProtocol) {
        self.coordinator = coordinator
        self.visitsRepository = visitsRepository
        
        getCountries()
    }
    
    func updateCountriesList() {
        countries.removeAll()
        for country in CoreDataManager.shared.fetchCountries() {
            countries.append(CountryModel(flags: FlagModel(png: country.flag!), name: CountryNameModel(common: country.name!, official: ""), been: country.been))
        }
    }
}

// MARK: Private methods

private extension VisitsViewModel {
    func getCountries() {
#warning("По хороему надо бы логику доделать и обновлять список стран с бэка хотя ббы раз в месяц")
        if CoreDataManager.shared.fetchCountries().isEmpty {
            Task {
                do {
                    countries = try await self.visitsRepository.getAllCountries()
                    updateCountries = true
                    await MainActor.run {
                        for country in self.countries {
                            CoreDataManager.shared.createCountry(flag: country.flags.png,
                                                                 name: country.name.common, been: false)
                        }
                    }
                }
            }
        } else {
            updateCountriesList()
            updateCountries = true
        }
    }
}

