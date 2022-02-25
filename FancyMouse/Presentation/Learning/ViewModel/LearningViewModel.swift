//
//  LearningViewModel.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/25.
//

import SwiftUI

// 임시 타입
enum MemorizationStatus {
    case complete
    case incomplete
}

class LearningViewModel: ObservableObject {
    @Published var words: [Word] = []
    @Published var isCheckTapped = false
    @Published var isXmarkTapped = false
    @Published var cardScale: CGFloat = 1
    
    init() {
        fetchDummyData()
    }
    
    private func fetchDummyData() {
        var words: [Word] = []
        let spellings = ["comprehensive", "strategy", "complication", "dim", "access", "resource", "sentimental"]
        let meaningsList = [["포괄적인", "종합적인", "능력별 구분을 않는"], ["전략", "계획"], ["(상황을 더 복잡하게 만드는) 문제"], ["(빛이) 어둑한", "(장소가) 어둑한", "(형체가) 흐릿한"]
                            ,["(장소로의) 입장", "접근권, 접촉기회", "(컴퓨터에) 접속하다"], ["(자원, 재원", "원하는 목적을 이루는 데 도움이 되는) 재료[자산]", "자원[재원]을 제공하다"],
                            ["정서(감정)적인", "(지나치게) 감상적인"]]
        let memos = ["이건 제발 외우자! ㅜㅜ", "", "", "디자인 관련해서 자주 나오는 용어!", "", "", ""]
        let synonymsList: [[String]] = [["complete", "full"],[],[],["vague"],[],[],[]]
        let examplesList: [[String]] = [["a comprehensive survey of modern music."],[],[],["This light is too dim to read by."],[],[],[]]
        
        for idx in (0..<spellings.count) {
            let word = Word(id: idx, folderID: idx, createdAt: Date(timeIntervalSinceNow: Double(arc4random_uniform(100000))),
                            spelling: spellings[idx], meanings: meaningsList[idx],
                            memorizationStatus: .inProgress, memo: memos[idx], synonyms: synonymsList[idx], examples: examplesList[idx], urlString: "")
            words.append(word)
        }
        
        self.words = words
    }
    
    //TODO: 페이징 처리, 단어가 5개만 남았을 때, 한번에 10개씩 불러오기
    // 암기 완료 버튼 누르거나 우측으로 스와이프 시 해당 단어 스테이터스 암기 완료로 변경 및 반영
    func getCardIndex(cardWord: Word) -> Int {
        let index = words.firstIndex { word in
            // FIXME: 나중에 단어 아이디로 변경
            return cardWord.id == word.id
        } ?? 0
        
        return index
    }
    
    func endSwipeActions(memorizationStatus: MemorizationStatus) {
        withAnimation(.none) {
//            endSwipe = true
            if memorizationStatus == .complete {
                isCheckTapped.toggle()
            } else {
                isXmarkTapped.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interactiveSpring()) {
                if memorizationStatus == .complete {
                    self.isCheckTapped.toggle()
                } else {
                    self.isXmarkTapped.toggle()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if !self.words.isEmpty {
                withAnimation {
                    self.words.removeFirst()
                    self.cardScale = 1
                }
            }
        }
    }
}
