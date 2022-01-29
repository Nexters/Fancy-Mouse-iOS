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
    let createdAt: Date
    let memo: String
    let status: Status
    
    enum Status {
        case ready, inProgress, fininshed
        
        var description: String {
            switch self {
            case .ready: return "미암기"
            case .inProgress: return "암기중"
            case .fininshed: return "암기완료"
            }
        }
    }
}
