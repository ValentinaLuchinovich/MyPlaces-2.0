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
    // Локальное свойство для checkBox
    var been: Bool = false
    
    init(flags: FlagModel, name: CountryNameModel, been: Bool) {
        self.flags = flags
        self.name = name
        self.been = been
    }

    init(_ model: CountryAPIModel) {
        flags = FlagModel(model.flags)
        name = CountryNameModel(model.name)
    }
}

struct FlagModel {
    var png: String = ""
    var svg: String = ""
    
    init(png: String = "" ,
         svg: String = "") {
        self.png = png
        self.svg = svg
    }
    
    init(_ model: FlagAPIModel) {
        png = model.png
        svg = model.svg
    }
}

struct CountryNameModel {
    var common: String = ""
    var official: String = ""
    
    init(common: String = "" ,
         official: String = "") {
        self.common = common
        self.official = official
    }
    
    
    init(_ model: CountryNameAPIModel) {
        common = model.common
        official = model.official
    }
}
