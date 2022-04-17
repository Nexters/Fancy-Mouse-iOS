//
//  User.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/04/17.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            let udValue = UserDefaults.standard.object(forKey: key) as? T
            switch (udValue as Any) {
            case Optional<Any>.some(let value):
                return (value as? T) ?? defaultValue
            case Optional<Any>.none:
                return defaultValue
            default:
                return udValue ?? defaultValue
            }
        }
        set {
            switch (newValue as Any) {
            case Optional<Any>.some(let value):
                UserDefaults.standard.set(value, forKey: key)
            case Optional<Any>.none:
                UserDefaults.standard.removeObject(forKey: key)
            default:
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

final class UserManager {
    @UserDefault(key: "userID", defaultValue: nil)
    static var userID: String?
    
    @UserDefault(key: "userEmail", defaultValue: nil)
    static var userEmail: String?
    
    @UserDefault(key: "userName", defaultValue: nil)
    static var userName: String?
}
