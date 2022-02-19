//
//  FolderUseCaseProtocol.swift
//  FancyMouse
//
//  Created by suding on 2022/02/10.
//

import Foundation
import RxSwift

protocol FolderUseCase {
    func createFolder(folderName: String, folderColor: String) -> Observable<Folder>
    
    func folderList() -> Observable<[Folder]>
    
    func update(folder: Folder, folderColor: String, name: String) -> Observable<Folder>

    func delete(folder: Folder) -> Observable<Folder>
}
