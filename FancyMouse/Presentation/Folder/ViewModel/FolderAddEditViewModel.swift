//
//  FolderAddEditViewModel.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/22.
//

import RxRelay

final class FolderAddEditViewModel {
    var folderName = BehaviorRelay<String>(value: .init())
    var folderColor = BehaviorRelay<String>(value: .init())
    var folderID = BehaviorRelay<String>(value: .init())
    
    let colorList = [
        UIColor.folder01,
        UIColor.folder02,
        UIColor.folder03,
        UIColor.folder04,
        UIColor.folder05,
        UIColor.folder06,
        UIColor.folder07,
        UIColor.folder08,
        UIColor.folder09,
        UIColor.folder10,
        UIColor.folder11,
        UIColor.folder00
    ]
    
    init(_ originalNameString: String, _ originalColorString: String) {
        self.folderName.accept(originalNameString)
        self.folderColor.accept(originalColorString)
    }
}
