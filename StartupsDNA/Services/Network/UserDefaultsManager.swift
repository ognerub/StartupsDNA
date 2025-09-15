//
//  UserDefaultsManager.swift
//  EffectiveMobile
//
//  Created by Alexander Ognerubov on 04.09.2025.
//

import Foundation

enum StorageKeyNames: String {
    case serverToken = "serverToken"
}

final class UserDefaultsManager {
    
    private let userDefaults = UserDefaults.standard

    var serverToken: String? {
        get {
            userDefaults.string(forKey: StorageKeyNames.serverToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: StorageKeyNames.serverToken.rawValue)
        }
    }
}
