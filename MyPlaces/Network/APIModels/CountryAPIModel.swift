//
//  CountryAPIModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 20.03.2025.
//

/// Модель запроса на получение списка стран c сервера
struct CountryAPIModel {
    let flags: FlagAPIModel
    let name: CountryNameAPIModel
}

struct FlagAPIModel {
    let png: String
    let svg: String
}

struct CountryNameAPIModel {
    let common: String
    let official: String
}
