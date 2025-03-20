//
//  APIRequest.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 19.03.2025.
//

import Foundation
import SwiftyJSON

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum Host: String {
    case countries = "https://restcountries.com/v3.1/all?fields=name,flags"
}

public protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var host: Host { get }
}

public typealias APIRequestQuery = [String: Any]

/// Модель отправляемого запроса на сервер
public struct APIRequest<EndpointType: APIEndpoint> {
    let endpoint: EndpointType
    let query: APIRequestQuery
    let body: JSON?
    
    public init(endpoint: EndpointType, query: APIRequestQuery = APIRequestQuery(), body: JSON? = nil) {
        self.endpoint = endpoint
        self.query = query
        self.body = body
    }
}
