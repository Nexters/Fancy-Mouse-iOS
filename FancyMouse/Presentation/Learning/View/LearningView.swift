//
//  LearningView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/13.
//

import SwiftUI

struct CompleteButton: View {
//    @Binding var isTapped: Bool
    @EnvironmentObject var viewModel: LearningViewModel
    
    var body: some View {
        HStack(spacing: 5) {
            Image("check")
                .frame(width: 13, height: 16)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: viewModel.isCheckTapped ? 8 : 16))
            if viewModel.isCheckTapped {
                Text("암기완료")
                    .spoqaBold(size: 16)
                    .padding(.trailing, 16)
            }
        }
        .background(Color.folder02)
        .foregroundColor(.white)
        .cornerRadius(16)
        .onTapGesture {
            viewModel.endSwipeActions(memorizationStatus: .complete) 
        }
    }
}

struct InCompleteButton: View {
//    @Binding var isTapped: Bool
    @EnvironmentObject var viewModel: LearningViewModel
    
    var body: some View {
        HStack(spacing: 5) {
            if viewModel.isXmarkTapped {
                Text("미암기")
                    .spoqaBold(size: 16)
                    .padding(.leading, 16)
            }
            
            Image("xmark")
                .frame(width: 16, height: 16)
                .padding(EdgeInsets(top: 16, leading: viewModel.isXmarkTapped ? 8 : 16, bottom: 16, trailing: 16))
        }
        .background(Color.folder07)
        .foregroundColor(.white)
        .cornerRadius(16)
        .onTapGesture {
            viewModel.endSwipeActions(memorizationStatus: .incomplete)
        }
    }
}

struct CardTestModel: Identifiable {
    let id = UUID()
    let word: String
}

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

struct CardContainerView: View {
    @EnvironmentObject var viewModel: LearningViewModel
    
//    @State var offset: CGFloat = 0
    @State private var translation: CGSize = .zero
    
//    @State var endSwipe: Bool = false
//    @GestureState var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            ForEach(viewModel.words.reversed()) { word in
                let index = CGFloat(viewModel.getCardIndex(cardWord: word))
                let topOffset = (index <= 2 ? index : 2) * 10 * viewModel.cardScale

                GeometryReader { proxy in
                    let size = proxy.size

                    ZStack {
                        CardStackView(word: word)
                            .environmentObject(viewModel)
//                                .frame(width: size.width - (topOffset * 4), height: size.height )
                            .frame(width: size.width - (topOffset * 4), height: size.height - (topOffset * 3))
                            .offset(y: topOffset * 2.5)
//                            .offset(x: offset)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .fullScreenCover(isPresented: .constant(viewModel.words.isEmpty)) {
            LearningIntroView()
        }
    }
}

extension View {
    var mainBounds: CGRect {
        return UIScreen.main.bounds
    }
}

struct LearningView: View {
    @EnvironmentObject var viewModel: LearningViewModel
    
    let rectWidth = UIScreen.main.bounds.width
    let rectHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.primaryDark
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    CardContainerView()
                        .padding(EdgeInsets(top: rectHeight * 0.091, leading: 0, bottom: rectHeight * 0.137, trailing: 0))
                    
                    HStack {
                        InCompleteButton()
                        Spacer()
                        CompleteButton()
                    }
                    .padding(EdgeInsets(top: 0, leading: 36, bottom: rectHeight * 0.091, trailing: 36))
                }
                .padding(.horizontal, rectWidth * 0.073)
            }
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView().environmentObject(LearningViewModel())
    }
}
