//
//  HomeWordCellViewModel.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/01/31.
//

import Foundation
import RxRelay
import RxSwift

final class HomeWordCellViewModel: WordCellViewModelProtocol {
    private let useCase: HomeWordUseCaseProtocol
    
    private let wordRelay: BehaviorRelay<Word>
    private let loadingRelay: BehaviorRelay<Bool> = .init(value: false)
    let hidingStatusObservable: Observable<HomeViewModel.HidingStatus>
    
    private var word: Word {
        wordRelay.value
    }
    
    private let disposeBag = DisposeBag()
    
    init(
        useCase: HomeWordUseCaseProtocol,
        word: Word,
        hidingStatusObservable: Observable<HomeViewModel.HidingStatus>
    ) {
        self.useCase = useCase
        wordRelay = .init(value: word)
        self.hidingStatusObservable = hidingStatusObservable
    }
    
    func toggleMemorizationStatus() {
        let currentWordStatus = word.memorizationStatus
        
        guard let toggledStatus = currentWordStatus.toggledStatus
        else { return }
        
        changeMemorizationStatus(to: toggledStatus, of: word.id)
    }
}

private extension HomeWordCellViewModel {
    func changeMemorizationStatus(to status: Word.MemorizationStatus, of wordID: WordID) {
        let isNotLoading = loadingRelay.value
        guard isNotLoading else { return }
        
        loadingRelay.accept(true)
        useCase.changeMemorizationStatus(to: status, of: wordID)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.wordRelay.accept($0)
                self?.loadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeWordCellViewModel {
    var wordObservable: Observable<Word> {
        wordRelay.asObservable()
    }
    
    var loadingObservable: Observable<Bool> {
        loadingRelay.asObservable()
    }
}
