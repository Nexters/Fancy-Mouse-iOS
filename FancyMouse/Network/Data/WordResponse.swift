//
//  WordResponse.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/30.
//

import Foundation

struct WordResponse: Decodable {
    let spelling: String
    let meaning: String
    let status: String
    let createdAt: Date
    let memo: String?
}

extension WordResponse {
    var mappedWord: Word {
        Word(
            spelling: spelling,
            meaning: meaning,
            status: Word.Status(status),
            createdAt: createdAt,
            memo: memo
        )
    }
}
