//
//  FolderUseCaseProtocol.swift
//  FancyMouse
//
//  Created by suding on 2022/02/10.
//

import RxSwift

protocol FolderUseCaseProtocol {
    func createFolder(name: String, color: String) -> Observable<Folder>
    
    func fetchFolder() -> Observable<[Folder?]>
    
    func update(folderID: String, folderColor: String, folderName: String) -> Observable<Folder>

    func delete(_ folderID: String, completion: @escaping () -> Void) //TODO: FolderID typealias -> String 타입으로 변환 후 파라미터 수정 예정
}
