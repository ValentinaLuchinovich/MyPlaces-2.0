//
//  APIResponse.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 19.03.2025.
//

import Foundation

/// Модель полученного ответа с сервера
public struct APIResponse<ResultType: Decodable> {
    public let data: ResultType?
    public let error: ErrorResponseAPIModel?
    
    public init(data: ResultType?) {
        self.data = data
        error = nil
    }
    
    public init(error: ErrorResponseAPIModel?) {
        data = nil
        self.error = error
    }
}

/// Указатель, что в случае успеха тело response будет пустое
public struct NoneResult: Decodable {
    public init() {}
}
