//
//  WordResponse.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/30.
//

import Foundation

struct WordResponse: Decodable {
    let wordID: String
    let folderID: String
    let createdAt: String
    let spelling: String
    let meanings: [String]
    let status: WordStatusResponse
    let memo: String?
    let synonyms: [String]
    let examples: [String]
    let urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case wordID = "wordId"
        case folderID = "folderId"
        case urlString = "url"
        case spelling, meanings, status, createdAt, memo, synonyms, examples
    }
}

extension WordResponse {
    enum WordStatusResponse: Int, Decodable {
        case unknown, ready, inProgress, fininshed
        
        var mappedWordStatus: Word.MemorizationStatus {
            switch self {
            case .unknown: return .unknown
            case .ready: return .incomplete
            case .inProgress: return .inProgress
            case .fininshed: return .complete
            }
        }
    }
}

extension WordResponse {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
        
        return dateFormatter
    }()
    
    var mappedWord: Word {
        let createdAt = Self.dateFormatter.date(from: self.createdAt) ?? Date()
        return Word(
            id: wordID, folderID: folderID,
            createdAt: createdAt,
            spelling: spelling, meanings: meanings,
            memorizationStatus: status.mappedWordStatus,
            memo: memo, synonyms: synonyms, examples: examples,
            urlString: urlString
        )
    }
}
