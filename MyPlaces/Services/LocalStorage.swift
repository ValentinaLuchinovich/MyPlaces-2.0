//
//  LocalStorage.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 11.04.2025.
//

import Foundation

// MARK: LocalStorage

/// Локальное хранилище данных
public final class LocalStorage {
    
    /// Фото профиля
    public static var profilePhoto: Data? {
        set {
            if newValue != nil {
                UserDefaultsHelper.set(.profilePhoto, newValue)
            }
            else {
                UserDefaultsHelper.remove(.profilePhoto)
            }
        }
        get {
            UserDefaultsHelper.get(.profilePhoto)
        }
    }
}
