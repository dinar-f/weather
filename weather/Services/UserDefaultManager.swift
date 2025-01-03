//
//  UserDefaultManager.swift
//  weather
//
//  Created by Dinar on 19.12.2024.
//

import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    func saveValue<T>(_ value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue<T>(forKey key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
}

