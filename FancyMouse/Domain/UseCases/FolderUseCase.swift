//
//  FolderUseCase.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/24.
//

import RxSwift

protocol FolderUseCaseProtocol {
    func createFolder(folderName: String, folderColor: UIColor)
    
    func fetchFolder() -> Observable<[Folder]>
    
    func update(folder: Folder, folderColor: String, folderName: String)
    
    func delete(_ folderID: FolderID)
}
