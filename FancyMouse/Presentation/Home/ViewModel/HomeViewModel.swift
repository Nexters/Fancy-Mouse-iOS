//
//  HomeViewModel.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/07.
//

import Foundation
import RxRelay
import RxSwift

final class HomeViewModel {
    private let useCase: HomeUseCaseProtocol
    private let maxWordsCount: Int
    
    private let wordsRelay: BehaviorRelay<[Word]> = .init(value: [])
    private let hidingStatusRelay: BehaviorRelay<HidingStatus>
    
    private let disposeBag = DisposeBag()
    
    init(
        useCase: HomeUseCaseProtocol,
        hidingStatusRelay: BehaviorRelay<HidingStatus>,
        maxWordsCount: Int = 10
    ) {
        self.useCase = useCase
        self.hidingStatusRelay = hidingStatusRelay
        self.maxWordsCount = maxWordsCount
    }
    
    func loadWords() {
        useCase.loadWords()
            .subscribe(onNext: { [weak self] in
                self?.wordsRelay.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    func suffleWords() {
        useCase.suffleWords()
            .subscribe(onNext: { [weak self] in
                self?.wordsRelay.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    func changeHidingStatus(with hidingStatus: HidingStatus) {
        hidingStatusRelay.accept(hidingStatus)
    }
    
    enum HidingStatus {
        case none, word, meaning
    }
}

extension HomeViewModel {
    var wordsObservable: Observable<[Word]> {
        wordsRelay.asObservable().take(maxWordsCount)
    }
    
    var hidingStatusObservable: Observable<HidingStatus> {
        hidingStatusRelay.asObservable()
    }
}
