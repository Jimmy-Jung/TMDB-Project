//
//  UserDefaultManager.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/26.
//

import Foundation

typealias UM = UserDefaultManager

struct UserDefaultManager {
    
    @UserDefault(key: KeyEnum.isLaunched.rawValue, defaultValue: false)
    static var isLaunched: Bool
    
    enum KeyEnum: String {
        case isLaunched
    }
}

extension UserDefaultManager {
    @propertyWrapper
    /// 유저 디퐅트
    struct UserDefault<T> {
        private let key: String
        private let defaultValue: T
        
        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        var wrappedValue: T {
            get {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}
