//
//  WordResponse.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/30.
//

import Foundation

struct WordResponse: Decodable {
    let wordID: Int
    let folderID: Int
    let createdAt: Date
    let spelling: String
    let meanings: [String]
    let status: Int
    let memo: String
    let synonyms: [String]
    let examples: [String]
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case wordID = "wordId"
        case folderID = "folderId"
        case urlString = "url"
        case spelling, meanings, status, createdAt, memo, synonyms, examples
    }
}

extension WordResponse {
    var mappedWord: Word {
        Word(
            wordID: wordID, folderID: folderID,
            createdAt: createdAt,
            spelling: spelling, meanings: meanings,
            status: Word.Status(status),
            memo: memo, synonyms: synonyms, examples: examples,
            urlString: urlString
        )
    }
}
