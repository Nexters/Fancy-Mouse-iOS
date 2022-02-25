//
//  FolderUseCaseProtocol.swift
//  FancyMouse
//
//  Created by suding on 2022/02/10.
//

import RxSwift

protocol FolderUseCaseProtocol {
    func createFolder(folderName: String, folderColor: String)
    
    func fetchFolder() -> Observable<[Folder]>
    
    func update(folderID: FolderID, folderColor: String, folderName: String)

    func delete(_ folderID: FolderID)
}
