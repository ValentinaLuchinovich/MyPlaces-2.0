//
//  LogService.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 19.03.2025.
//

import OSLog

/// Сервис для ведения лога
public final class LogService {
    static private let log = OSLog(subsystem: "MyPlaces", category: "MyPlaces")
    
    /// Печать сообщения в лог (консоль)
    static func print(message: String, type: OSLogType = .info) {
        os_log("%{public}@", log: log, type: type, message)
    }
}
