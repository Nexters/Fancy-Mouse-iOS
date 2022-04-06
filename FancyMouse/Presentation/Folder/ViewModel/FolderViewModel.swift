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
    struct Input {
        var currentFolderName: Observable<String>
        var currentFolderColor: Observable<String>
    }
    
    struct Output {
        var isEnableCreateFolder: Driver<Bool>
    }
    
    private let useCase: FolderUseCaseProtocol
    private let disposeBag = DisposeBag()
    lazy var folderList = BehaviorRelay<[Folder?]>(value: [])
    var isFolderExist = false
    
    init(useCase: FolderUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let isEnableCreateFolder = Observable.combineLatest(
            input.currentFolderName,
            input.currentFolderColor
        ).map {
            return !$0.0.isEmpty && !$0.1.isEmpty
        }.asDriver(onErrorJustReturn: false)
        
        return Output(isEnableCreateFolder: isEnableCreateFolder)
    }

    func createFolder(name: String, color: String) {
        useCase.createFolder(name: name, color: color)
      
        let itemsReference = Database.database().reference(withPath: "sangjin")
        let userItemReference = itemsReference.child("foldersCount")
        userItemReference.setValue(folderList.value.count)
    }

    func fetchFolder() {
        useCase.fetchFolder()
            .bind { [weak self] in
                self?.folderList.accept($0)
            }
            .disposed(by: disposeBag)
    }

    func update(folderID: String, folderColor: String, folderName: String) {
        useCase.update(folderID: folderID, folderColor: folderColor, folderName: folderName)
    }
    //TODO: 작업 예정
    func delete(_ folderID: String) {
//        useCase.delete(folderID)
//        fetchFolder()
    }
}
