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
    var filteredCountries: [CountryModel] = []
    
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
            countries.append(CountryModel(flags: FlagModel(png: country.flag!), name: CountryNameModel(common: country.name!, official: ""), ссa2: country.cca2 ?? "", been: country.been))
        }
    }
    
    func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountries = []
        } else {
            filteredCountries = countries.filter { country in
                country.name.common.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func getCountriesForDisplay() -> [CountryModel] {
        filteredCountries.isEmpty ? countries : filteredCountries
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
                                                                 name: country.name.common,
                                                                 cca2: country.cca2,
                                                                 been: false)
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

