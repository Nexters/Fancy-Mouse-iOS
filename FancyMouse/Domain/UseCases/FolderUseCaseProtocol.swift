//
//  FolderUseCaseProtocol.swift
//  FancyMouse
//
//  Created by suding on 2022/02/10.
//

import Foundation
import RxSwift

protocol FolderUseCaseProtocol {
    func createFolder(folderName: String, folderColor: String) -> Observable<Folder>
    
    func folderList() -> Observable<[Folder]>
    
    func update(folder: Folder, folderColor: String, folderName: String) -> Observable<Folder>

    func delete(folder: Folder) -> Observable<Folder>
}