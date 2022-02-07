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
    private let isSpellingHiddenRelay: BehaviorRelay<Bool> = .init(value: false)
    private let isMeaningHiddenRelay: BehaviorRelay<Bool> = .init(value: false)
    
    private let disposeBag = DisposeBag()
    
    init(useCase: HomeWordUseCaseProtocol, word: Word) {
        self.useCase = useCase
        wordRelay = .init(value: word)
    }
    
    func toggleSpellingHiddenState() {
        isSpellingHiddenRelay
            .accept(!isSpellingHiddenRelay.value)
    }
    
    func toggleMeaningHiddenState() {
        isMeaningHiddenRelay
            .accept(!isMeaningHiddenRelay.value)
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
    var isSpellingHiddenObservable: Observable<Bool> {
        isSpellingHiddenRelay.asObservable()
    }
    
    var isMeaningHiddenObservable: Observable<Bool> {
        isMeaningHiddenRelay.asObservable()
    }
    
    var wordObservable: Observable<Word> {
        wordRelay.asObservable()
    }
}

