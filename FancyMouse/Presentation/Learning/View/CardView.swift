//
//  CardView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/19.
//

import SwiftUI

struct WordMeaningRow: View {
    let number: Int
    let meaning: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Text(String(number) + ".")
                .spoqaBold(size: 14)
                .frame(alignment: .trailing)
            Text(meaning)
                .spoqaRegular(size: 14)
        }
        .foregroundColor(.gray70)
    }
}

struct CardView: View {
    @State private var isVisiable = false
    
    var totalCardNum: Int
    let word: Word
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack(alignment: .top) {
                HStack(spacing: 4) {
                    Text(String(word.id + 1))
                        .spoqaBold(size: 12)
                        .foregroundColor(.primaryColor)
                    Text("/")
                    Text(String(totalCardNum))
                }
                .spoqaRegular(size: 12)
                .foregroundColor(.gray50)
                
                Spacer()
                Text(word.memorizationStatus.description)
                    .spoqaBold(size: 12)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                    .background(Color.primaryColor)
                    .cornerRadius(1000)
            }
            
            Text(word.spelling)
                .spoqaBold(size: 28)
                .foregroundColor(.primaryColor)

            Divider()
                .frame(height: 1)
                .foregroundColor(.gray30)
            
            if isVisiable {
                // TODO: 유동적으로 데이터를 반영하기에는 list나 LazyVStack이 좋을듯, 데이터 구조 잡히면 변경할 예정, row 뷰도 별도로 뺄 예정
                VStack(alignment: .leading, spacing: 6) {
                    ForEach((0..<word.meanings.count)) { idx in
                        WordMeaningRow(number: idx, meaning: word.meanings[idx])
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                Text("우측 하단의 아이콘을\n터치하면 뜻을 확인할 수 있어요!")
                    .spoqaRegular(size: 14)
                    .foregroundColor(.gray70)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            }
 
            HStack {
                Spacer()
                
                Button {
                    isVisiable.toggle()
                } label: {
                    Image(isVisiable ? "btn_view" : "btn_hide")
                }
            }
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
        .background(Color.white)
        .cornerRadius(30)
        .shadow(
            color: Color.gray50,
            radius: 1,
            x: 0,
            y: 1
        )
    }
}

struct CardStackView: View {
//    @State var offset: CGFloat = 0
    @State private var translation: CGSize = .zero
    @State var endSwipe: Bool = false
    @GestureState var isDragging: Bool = false
    @EnvironmentObject var viewModel: LearningViewModel
    
    var word: Word

    var body: some View {
        GeometryReader { proxy in
            CardView(totalCardNum: 7, word: word)
            .rotationEffect(
                .degrees(Double(self.translation.width / proxy.size.width * 20)),
                anchor: .bottom
            )
            .offset(x: self.translation.width, y: self.translation.height)
            .animation(.interactiveSpring(
                response: 0.5,
                blendDuration: 0.3)
            )
            .gesture(
                DragGesture()
                    .updating($isDragging, body: { value, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        self.translation = value.translation
                        let cardWidth = (mainBounds.width - 48) / 2
                        viewModel.cardScale = max((cardWidth - abs(self.translation.width)) / cardWidth, 0.2) // 0.7

//                        offset = (isDragging ? self.translation.width : .zero)
                    })
                    .onEnded({ value in
                        let width = mainBounds.width - 48
                        self.translation = value.translation
                        let checkingStatus = abs(self.translation.width)
    //                                endSwipe = true
                        withAnimation {
                            if checkingStatus > (width / 2) {
                                self.translation.width = (self.translation.width > 0 ? width : -width) * 2
                                endSwipe = true
                                viewModel.endSwipeActions(memorizationStatus: self.translation.width > 0 ? .complete : .incomplete)

                            } else {
                                viewModel.cardScale = 1
                                self.translation = .zero
                            }
                        }
                    })
            )
        }
    }
}

//struct CardStackView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardStackView(word: Word(id: 1, folderID: 1, createdAt: Date(), spelling: "", meanings: ["ㅎ"], memorizationStatus: .inProgress, memo: "", synonyms: ["ㅎ"], examples: [], urlString: ""), testVal: .constant(1)
//            .environmentObject(LearningViewModel())
//    }
//}
