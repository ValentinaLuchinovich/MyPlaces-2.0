//
//  ErrorResponseAPIModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 19.03.2025.
//

/// Модель ошибки на ответ сервера
public struct ErrorResponseAPIModel: Decodable, Error {
    
    public let message: String
    public let errors: [String: [String]]?
    
    public init(
        message: String,
        errors: [String: [String]]? = nil
    ) {
        self.message = message
        self.errors = errors
    }
    
    enum CodingKeys: String, CodingKey {
        case message, errors
    }
}
