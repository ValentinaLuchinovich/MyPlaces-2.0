//
//  VisitsService.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 20.03.2025.
//

import Foundation
import SwiftyJSON

enum VisitsAPIEndpoint: APIEndpoint {
    
    case getAllCountries
    
    var path: String {
        switch self {
        case .getAllCountries: ""
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var host: Host {
        .countries
    }
}

protocol VisitsServiceProtocol {
    func getAllCountries() async throws -> [CountryAPIModel]
}

final class VisitsService {
    
    private let apiClient = APIClient.shared
}

extension VisitsService: VisitsServiceProtocol {
    
    func getAllCountries() async throws -> [CountryAPIModel] {
        let request: APIRequest<VisitsAPIEndpoint> = .init(endpoint: .getAllCountries)
        return try await apiClient.sendRequest(request: request)
    }
}
