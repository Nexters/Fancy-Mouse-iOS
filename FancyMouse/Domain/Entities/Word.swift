//
//  Word.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation

struct Word {
    let wordID: Int
    let folderID: Int
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
    enum Status: CaseIterable {
        case ready, inProgress, fininshed, unknown
        
        init(_ description: String) {
            self = Status.allCases.filter { status in
                status.description == description
            }.first ?? .unknown
        }
        
        init(_ number: Int) {
            switch number {
            case 0: self = .ready
            case 1: self = .inProgress
            case 2: self = .fininshed
            default: self = .unknown
            }
        }
        
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
