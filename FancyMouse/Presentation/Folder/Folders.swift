//
//  Folders.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/04/07.
//

struct Folders {
    private(set) var values: [Folder?] = [nil]
    
    var count: Int {
        values.count
    }
    
    mutating func add(_ folder: Folder) {
        values.append(folder)
        values = values.compactMap { $0 }.sorted { $0.createdAt < $1.createdAt }
        
        guard count < 12 else { return }
        values.append(nil)
    }
}
