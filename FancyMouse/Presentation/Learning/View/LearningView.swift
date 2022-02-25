//
//  LearningView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/13.
//

import SwiftUI

struct IncompleteButton: View {
    @Binding var isTapped: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Image("check")
                .frame(width: 13, height: 16)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: isTapped ? 8 : 16))
            if isTapped {
                Text("암기완료")
                    .spoqaBold(size: 16)
                    .padding(.trailing, 16)
            }
        }
        .background(Color.folder02)
        .foregroundColor(.white)
        .cornerRadius(16)
        .onTapGesture {
            withAnimation(.interactiveSpring()) {
                isTapped.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.interactiveSpring()) {
                    isTapped.toggle()
                }
            }
        }
    }
}

struct CompleteButton: View {
    @Binding var isTapped: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            if isTapped {
                Text("미암기")
                    .spoqaBold(size: 16)
                    .padding(.leading, 16)
            }
            
            Image("xmark")
                .frame(width: 16, height: 16)
                .padding(EdgeInsets(top: 16, leading: isTapped ? 8 : 16, bottom: 16, trailing: 16))
        }
        .background(Color.folder07)
        .foregroundColor(.white)
        .cornerRadius(16)
        .onTapGesture {
            withAnimation(.interactiveSpring()) {
                isTapped.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.interactiveSpring()) {
                    isTapped.toggle()
                }
            }
        }
    }
}

struct CardTestModel: Identifiable {
    let id = UUID()
    let word: String
}

class LearningViewModel: ObservableObject {
    @Published var words: [Word] = []
    
    init() {
        fetchDummyData()
    }
    
    private func fetchDummyData() {
        words = Array(repeating: Word(wordID: 0, folderID: 0, createdAt: Date(), spelling: "Purpose", meanings: ["(이루고자 하는, 이루어야 할) 목적,(특정 상황에서 무엇을) 하기 위함.","(삶에 의미를 주는) 목적"], memorizationStatus: .inProgress, memo: "", synonyms: [""], examples: [""], urlString: ""), count: 10)
    }
    
    //TODO: 페이징 처리, 단어가 5개만 남았을 때, 한번에 10개씩 불러오기
    
    // 암기 완료 버튼 누르거나 우측으로 스와이프 시 해당 단어 스테이터스 암기 완료로 변경 및 반영
    
}

class CardViewModel: ObservableObject {
    @Published var dummyData: [CardTestModel] =
    [CardTestModel(word: "1"), CardTestModel(word: "1"), CardTestModel(word: "1"), CardTestModel(word: "1"), CardTestModel(word: "1"), CardTestModel(word: "1"), CardTestModel(word: "1")]
    
    func getIndex(dummy: CardTestModel) -> Int {
        let index = dummyData.firstIndex { card in
            return dummy.id == card.id
        } ?? 0
        
        return index
    }
}

struct CardContainerView: View {
//    @ObservedObject var viewModel = CardViewModel()
    @StateObject var viewModel = CardViewModel()
    
    @State var offset: CGFloat = 0
    
    @State private var translation: CGSize = .zero
    
    @State var endSwipe: Bool = false
    @GestureState var isDragging: Bool = false
    
    @State var testVal: CGFloat = 1
    
    var body: some View {
        ZStack {
            if viewModel.dummyData.isEmpty {
                //FIXME: 임시
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ForEach(viewModel.dummyData.reversed()) { card in
                    let index = CGFloat(viewModel.getIndex(dummy: card))
                    let topOffset = (index <= 2 ? index : 2) * 10 * testVal
                    
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        ZStack {
                            // 카드뷰 자체가 오프셋을 갖고..
                            // 프레임하고 y오프셋 조절
                            // 백그라운드 색 조절 필요
                            CardStackView(card: card, testVal: $testVal)
                                .environmentObject(viewModel)
                                .frame(width: size.width - (topOffset * 4), height: size.height)
                                .offset(y: topOffset)
                                .offset(x: offset)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct LearningView: View {
    @State private var checkIsTapped = false
    @State private var xmarkIsTapped = false
    
    let rectWidth = UIScreen.main.bounds.width
    let rectHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 0) {
                CardContainerView()
                    .padding(EdgeInsets(top: rectHeight * 0.091, leading: 0, bottom: rectHeight * 0.137, trailing: 0))
                
                HStack {
                    CompleteButton(isTapped: $checkIsTapped)
                    Spacer()
                    IncompleteButton(isTapped: $xmarkIsTapped)
                }
                .padding(EdgeInsets(top: 0, leading: 36, bottom: rectHeight * 0.091, trailing: 36))
            }
            .padding(.horizontal, rectWidth * 0.073)
        }
        .background(Color.primaryDark)
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
