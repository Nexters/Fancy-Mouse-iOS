//
//  WordUseCaseProtocol.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation
import RxSwift

protocol WordUseCaseProtocol {
    func changeMemorizationStatus(
        to newStatus: Word.MemorizationStatus,
        of wordID: WordID
    ) -> Observable<Word>
}

protocol WordEditUseCaseProtocol {
    func moveFolder(to folderID: FolderID, of wordID: WordID) -> Observable<Void>
    func editMemo(_ memo: String, wordID: WordID) -> Observable<Word>
}

protocol WordDeleteUseCaseProtocol {
    func deleteWord(_ wordID: WordID)
}

// MARK: Words
protocol WordsUseCaseProtocol {
    func loadWords() -> Observable<[Word]>
}

protocol HomeUseCaseProtocol: WordsUseCaseProtocol { }

protocol HomeWordUseCaseProtocol: WordUseCaseProtocol { }
