//
//  UserDefaultsHelper.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 11.04.2025.
//

import Foundation

/// Класс для работы с UserDefaults
public final class UserDefaultsHelper {
    
    /// Ключи-идентификаторы под которыми хранятся данные
    enum Keys: String, CaseIterable {
        case profilePhoto
    }
    
    /// Установить данные под указанным ключом
    static func set<T: Encodable>(_ key: Keys, _ value: T) {
        guard
            let data = try? JSONEncoder().encode(value)
        else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    /// Получить данные по указанному ключу
    static func get<T: Decodable>(_ key: Keys) -> T? {
        guard
            let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data,
            let value = try? JSONDecoder().decode(T.self, from: data)
        else { return nil }
        return value
    }
    
    /// Удалить данные под указанным ключом
    static func remove(_ key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    /// Очистить полностью UserDefaults
    static func clear() {
        for key in Keys.allCases {
            remove(key)
        }
    }
}
