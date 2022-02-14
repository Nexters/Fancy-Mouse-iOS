//
//  HomeWordCellViewModel.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/01/31.
//

import Foundation
import RxRelay
import RxSwift

final class HomeWordCellViewModel {
    private let useCase: HomeWordUseCaseProtocol
    
    private let wordRelay: BehaviorRelay<Word>
    private let hidingStatusRelay: BehaviorRelay<HomeViewModel.HidingStatus>
    private let loadingRelay: BehaviorRelay<Bool> = .init(value: false)
    
    private var word: Word {
        wordRelay.value
    }
    
    private let disposeBag = DisposeBag()
    
    init(
        useCase: HomeWordUseCaseProtocol,
        word: Word,
        hidingStatusRelay: BehaviorRelay<HomeViewModel.HidingStatus>
    ) {
        self.useCase = useCase
        wordRelay = .init(value: word)
        self.hidingStatusRelay = hidingStatusRelay
    }
    
    func changeStatus(to status: Word.Status, of wordID: WordID) {
        useCase.changeStatus(to: status, of: wordID)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.wordRelay.accept($0)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeWordCellViewModel {
    var wordObservable: Observable<Word> {
        wordRelay.asObservable()
    }
    
    var hidingStatusObservable: Observable<HomeViewModel.HidingStatus> {
        hidingStatusRelay.asObservable()
    }
    
    var loadingObservable: Observable<Bool> {
        loadingRelay.asObservable()
    }
}
