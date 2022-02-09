//
//  Word.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation

typealias WordID = Int
typealias FolderID = Int

struct Word: Equatable {
    let wordID: WordID
    let folderID: FolderID
    let createdAt: Date
    let spelling: String
    let meanings: [String]
    let status: Status
    let memo: String
    let synonyms: [String]
    let examples: [String]
    let urlString: String
}

extension Word {
    enum Status {
        case ready, inProgress, fininshed, unknown
        
        var description: String {
            switch self {
            case .ready: return "미암기"
            case .inProgress: return "암기중"
            case .fininshed: return "암기완료"
            case .unknown: return "알수없음"
            }
        }
    }
}
