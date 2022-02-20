//
//  FolderViewModel.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Foundation
import RxCocoa
import RxSwift

final class FolderViewModel {
    private let useCase: FolderUseCase
    
    init(useCase: FolderUseCase) {
        self.useCase = useCase
    }

    var folderLists: Observable<[Folder]> {
        return useCase.folderList()
    }
    
    private var list = [
        // MARK: Dummy
        Folder(folderCount: 12, folderColor: "yellow", folderName: "토익단어"),
        Folder(folderCount: 24, folderColor: "Gray60", folderName: "수능 단어"),
        Folder(folderCount: 5, folderColor: "Gray40", folderName: "필수단어")
    ]
    
    private lazy var store = BehaviorSubject<[Folder]>(value: list)
    
    func createFolder(folderName: String, folderColor: String) -> Observable<Folder> {
        let folder = Folder(folderCount: 0,
                            folderColor: folderColor,
                            folderName: folderName)
        if list.count == 10 {
        }
        list.insert(folder, at: 0)
        store.onNext(list)
        return Observable.just(folder)
    }
    
    func folderList() -> Observable<[Folder]> {
        return store
    }
    
    func update(folder: Folder, folderColor: String, folderName: String) -> Observable<Folder> {
        let updated = Folder(original: folder, updatedFolderColor: folderColor,
                             updatedFolderName: folderName)
        if let index = list.firstIndex(where: { $0 == folder }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        store.onNext(list)
        return Observable.just(updated)
    }
    
    func delete(folder: Folder) -> Observable<Folder> {
        if let index = list.firstIndex(where: { $0 == folder }) {
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(folder)
    }
}

