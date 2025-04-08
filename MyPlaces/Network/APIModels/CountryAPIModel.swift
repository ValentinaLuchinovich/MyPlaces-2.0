//
//  CountryAPIModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 20.03.2025.
//

/// Модель запроса на получение списка стран c сервера
struct CountryAPIModel: Decodable {
    let flags: FlagAPIModel
    let name: CountryNameAPIModel
    let cca2: String
}

struct FlagAPIModel: Decodable {
    let png: String
    let svg: String
}

struct CountryNameAPIModel: Decodable {
    let common: String
    let official: String
}
