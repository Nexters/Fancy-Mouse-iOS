//
//  WordUseCaseProtocol.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation
import RxSwift

protocol WordUseCaseProtocol {
    func changeStatus(to newStatus: Word.Status, of wordID: WordID) -> Observable<Word>
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

protocol WordsTestUseCaseProtocol: WordsUseCaseProtocol {
    func suffleWords() -> Observable<[Word]>
}

protocol HomeUseCaseProtocol: WordsTestUseCaseProtocol { }

protocol HomeWordUseCaseProtocol: WordUseCaseProtocol { }
