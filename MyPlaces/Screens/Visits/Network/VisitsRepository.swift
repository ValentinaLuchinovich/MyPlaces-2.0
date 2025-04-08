//
//  VisitsRepository.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 21.03.2025.
//

protocol VisitsRepositoryProtocol {
    
    func getAllCountries() async throws -> [CountryModel]
}

/// Репозиторий для получения данных о cтранах с сервера
final class VisitsRepository {
    
    // MARK: Private Properties
    private let visitsService: VisitsServiceProtocol
    
    // MARK: Initializer
    init (visitsService: VisitsServiceProtocol) {
        self.visitsService = visitsService
    }
}

// MARK: VisitsRepositoryProtocol

extension VisitsRepository: VisitsRepositoryProtocol {
    func getAllCountries() async throws -> [CountryModel] {
        let model = try await visitsService.getAllCountries()
        return .init(model.filter{$0.independent ?? true}.map { CountryModel($0)})
    }
}
