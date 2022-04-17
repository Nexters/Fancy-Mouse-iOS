//
//  MockData.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/04/17.
//

import Foundation

enum MockData {
    static let words: [Word] = {
        Self.spellings.enumerated().map { index, _ in
            Word(
                id: "\(index)",
                folderID: "\(index)",
                createdAt: Date(timeIntervalSinceNow: Double(arc4random_uniform(100000))),
                spelling: Self.spellings[index],
                meanings: Self.meaningsList[index],
                memorizationStatus: .inProgress,
                memo: Self.memos[index],
                synonyms: Self.synonymsList[index],
                examples: Self.examplesList[index],
                urlString: ""
            )
        }
    }()
    static let spellings = [
        "purpose",
        "comprehensive",
        "strategy",
        "complication",
        "dim",
        "access",
        "resource",
        "sentimental"
    ]
    static let meaningsList = [
        ["(이루고자 하는·이루어야 할) 목적", "(특정 상황에서 무엇을) 하기 위함, 용도, 의도", "(삶에 의미를 주는) 목적[목적의식]"],
        ["포괄적인", "종합적인", "능력별 구분을 않는"],
        ["전략", "계획"],
        ["(상황을 더 복잡하게 만드는) 문제", "복잡함"],
        ["(빛이) 어둑한", "(장소가) 어둑한", "(형체가) 흐릿한"],
        ["(장소로의) 입장", "접근권, 접촉기회", "(컴퓨터에) 접속하다"],
        ["자원, 재원", "원하는 목적을 이루는 데 도움이 되는) 재료[자산]", "자원[재원]을 제공하다"],
        ["정서(감정)적인", "(지나치게) 감상적인"]
    ]
    static let memos = [
        "꼭 외워야 하는데.. 외우기 쉽지않네..고민된다!",
        "이건 제발 외우자! ㅜㅜ",
        "",
        "",
        "디자인 관련해서 자주 나오는 용어!",
        "",
        "",
        ""
    ]
    static let synonymsList: [[String]] = [
        [],
        ["complete", "full"],
        [],
        [],
        ["vague"],
        [],
        [],
        []
    ]
    static let examplesList: [[String]] = [
        [],
        ["a comprehensive survey of modern music."],
        [],
        [],
        ["This light is too dim to read by."],
        [],
        [],
        []
    ]
}
