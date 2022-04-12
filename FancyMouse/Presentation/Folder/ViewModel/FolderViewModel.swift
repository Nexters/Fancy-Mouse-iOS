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
    
    struct FolderList {
        var folderListRelay: BehaviorRelay<[Folder?]>
    }
    
    private let useCase: FolderUseCaseProtocol
    private let disposeBag = DisposeBag()
    private let folderListRelay = BehaviorRelay<[Folder?]>(value: [])
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

    func createFolder(name: String, color: String, completion: @escaping (Int) -> Void) {
        var originFolderList = folderListRelay.value
        
        useCase.createFolder(name: name, color: color)
            .bind { [weak self] in
                originFolderList.append($0)
                originFolderList = originFolderList.compactMap { $0 }.sorted { $0.createdAt < $1.createdAt }
                if originFolderList.count < 12 { originFolderList.append(nil) }
                self?.folderListRelay.accept(originFolderList)
                completion(originFolderList.count)
            }.disposed(by: disposeBag)
      
        let itemsReference = Database.database().reference(withPath: "sangjin")
        let userItemReference = itemsReference.child("foldersCount")
        userItemReference.setValue(folderListRelay.value.count)
    }

    func fetchFolder(_ folderList: FolderList) {
        folderListRelay.bind {
            folderList.folderListRelay.accept($0)
        }.disposed(by: disposeBag)
        
        useCase.fetchFolder()
            .bind { [weak self] in
                self?.folderListRelay.accept($0)
            }
            .disposed(by: disposeBag)
    }

    func update(
        folderID: String,
        folderColor: String,
        folderName: String,
        completion: @escaping (Int) -> Void
    ) {
        var originFolderList = folderListRelay.value
        
        useCase.update(folderID: folderID, folderColor: folderColor, folderName: folderName)
            .bind { [weak self] in
                var indexNumber: Int?
                for idx in 0..<originFolderList.count
                where originFolderList[idx]?.folderID == folderID {
                    originFolderList[idx] = $0
                    indexNumber = idx
                }
                self?.folderListRelay.accept(originFolderList)
                guard let indexNumber = indexNumber else { return }
                completion(indexNumber)
            }.disposed(by: disposeBag)
    }
    //TODO: 작업 예정
    func delete(_ folderID: String) {
//        useCase.delete(folderID)
//        fetchFolder()
    }
}
