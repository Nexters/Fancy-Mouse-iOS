//
//  FolderViewModel.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Firebase
import RxSwift

final class FolderViewModel {
    private let useCase: FolderUseCaseProtocol
    private let disposeBag = DisposeBag()
    lazy var folderCount = BehaviorSubject<Int>(value: 0)
    lazy var folderList = BehaviorSubject<[Folder]>(value: [])

    init(useCase: FolderUseCaseProtocol) {
        self.useCase = useCase
    }

    func createFolder(folderName: String, folderColor: UIColor) {
        useCase.createFolder(folderName: folderName, folderColor: folderColor)
    }

    func fetchFolder() -> Observable<[Folder]> {
        useCase.fetchFolder()
            .bind { [weak self] in
                self?.folderCount.onNext($0.count)
                self?.folderList.onNext($0)
            }
            .disposed(by: disposeBag)
        
        return folderList
    }

    func update(folder: Folder, folderColor: String, folderName: String) {
        useCase.update(folder: folder, folderColor: folderColor, folderName: folderName)
    }
    
    func delete(_ folderID: FolderID) {
        useCase.delete(folderID)
    }
}
