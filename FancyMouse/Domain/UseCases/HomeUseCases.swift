//
//  HomeUseCases.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation

protocol WordUseCase {
    func changeStatus(to newStatus: Word.Status)
}

protocol WordTestUseCase: WordUseCase {
    func hideSpelling()
    func hideMeaning()
    func suffleWords()
}

protocol WordEditUseCase {
    // TODO: 폴더 변경을 어떻게 풀지 논의 필요
    func moveFolder(to folder: Folder)
    func editMemo(_ memo: String)
}

protocol WordDeleteUseCase {
    func deleteWord()
}

protocol RemoteWordEditUseCase: WordEditUseCase, WordDeleteUseCase { }

protocol CustomWordEditUseCase: WordEditUseCase {
    func editWord(_ word: String)
    func editMeaning(_ meaning: String)
}
