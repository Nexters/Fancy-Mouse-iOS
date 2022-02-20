//
//  Folder.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/30.
//

import Foundation

struct Folder: Equatable {
    var folderCount: Int
    var folderColor: String
    var folderName: String
    
    init(folderCount: Int, folderColor: String, folderName: String) {
        self.folderCount = folderCount
        self.folderColor = folderColor
        self.folderName = folderName
    }
    
    init(original: Folder, updatedFolderColor: String, updatedFolderName: String) {
        self = original
        self.folderColor = updatedFolderColor
        self.folderName = updatedFolderName
    }
}
