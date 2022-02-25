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
        let spellings = ["I", "Love", "Nexters", "Fancy", "Mouse", "Team", "🙂"]
        for idx in (0...6) {
            let word = Word(id: idx, folderID: 0, createdAt: Date(), spelling: spellings[idx], meanings: ["(이루고자 하는, 이루어야 할) 목적,(특정 상황에서 무엇을) 하기 위함.","(삶에 의미를 주는) 목적"], memorizationStatus: .inProgress, memo: "", synonyms: [""], examples: [""], urlString: "")
            words.append(word)
        }
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
