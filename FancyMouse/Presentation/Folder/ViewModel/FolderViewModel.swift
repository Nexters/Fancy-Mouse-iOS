//
//  FolderViewModel.swift
//  FancyMouse
//
//  Created by suding on 2022/02/12.
//

import Firebase
import RxCocoa
import RxSwift

final class FolderViewModel {
    private let useCase: FolderUseCaseProtocol
    private let disposeBag = DisposeBag()
    lazy var folderList = BehaviorRelay<[Folder?]>(value: [])
    
    init(useCase: FolderUseCaseProtocol) {
        self.useCase = useCase
    }

    func createFolder(count: Int, name: String, color: String) {
        useCase.createFolder(count: count, name: name, color: color)
    }

    func fetchFolder() {
        useCase.fetchFolder()
            .bind { [weak self] in
                self?.folderList.accept($0)
            }
            .disposed(by: disposeBag)
    }

    func update(folderID: FolderID, folderColor: String, folderName: String) {
        useCase.update(folderID: folderID, folderColor: folderColor, folderName: folderName)
    }
    //TODO: 작업 예정
    func delete(_ folderID: String) {
//        useCase.delete(folderID)
//        fetchFolder()
    }
}
