//
//  CountryModel.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 20.03.2025.
//

/// Модель запроса на получение списка стран
struct CountryModel {
    var flags: FlagModel = .init()
    var name: CountryNameModel = .init()
}

struct FlagModel {
    var png: String = ""
    var svg: String = ""
}

struct CountryNameModel {
    var common: String = ""
    var official: String = ""
}

