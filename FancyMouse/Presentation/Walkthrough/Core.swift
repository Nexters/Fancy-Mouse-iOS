//
//  Core.swift
//  FancyMouse
//
//  Created by suding on 2022/02/25.
//

import Foundation

class Core {
   static let shared = Core()
   
   func inNewUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
   func setIsNotNewUser () {
       UserDefaults.standard.set(true, forKey: "isNewUser")
   }
}
