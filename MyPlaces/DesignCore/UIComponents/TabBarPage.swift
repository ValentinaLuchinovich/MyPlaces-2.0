//
//  TabBarPage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit
import SnapKit

enum TabBarPage: CaseIterable {
    case visits, map, profile

    init?(index: Int) {
        switch index {
        case 0: self = .visits
        case 1: self = .map
        case 2: self = .profile
            default: return nil
        }
    }
    
    var title: String {
        var title = ""
        switch self {
        case .visits: title = "Путешествия"
        case .map: title = ""
        case .profile: title = "Профиль"
        }
        return title
    }
    
    var pageNumber: Int {
        var num = 0
        switch self {
        case .visits: num = 0
        case .map: num = 1
        case .profile: num = 2
        }
        return num
    }

    var icon: UIImage? {
        var icon: UIImage?
        switch self {
        case .visits: icon = UIImage(systemName: "map")
        case .map: icon = nil
        case .profile: icon = UIImage(systemName: "person")
        }
        return icon
    }
    
    var selectedIcon: UIImage? {
        var icon: UIImage?
        switch self {
        case .visits: icon = UIImage(systemName: "map.fill")
        case .map: icon = nil
        case .profile: icon = UIImage(systemName: "person.fill")
        }
        return icon
    }
}
