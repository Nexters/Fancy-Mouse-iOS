//
//  Word.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/01/28.
//

import Foundation

struct Word {
    let spelling: String
    let meaning: String
    let status: Status
    let createdAt: Date
    let memo: String?
}

extension Word {
    enum Status: CaseIterable {
        case ready, inProgress, fininshed
        
        init(_ description: String) {
            self = Status.allCases.filter { status in
                status.description == description
            }.first ?? .ready
        }
        
        var description: String {
            switch self {
            case .ready: return "미암기"
            case .inProgress: return "암기중"
            case .fininshed: return "암기완료"
            }
        }
    }
}
