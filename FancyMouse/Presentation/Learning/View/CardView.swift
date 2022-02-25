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
    var totalCardNum: Int = 200
    var currentCardNum: Int = 24
    var wordState: String = "암기중"// FIXME: 값 변경
    // Word 모델
    @State private var isVisiable: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack(alignment: .top) {
                HStack(spacing: 4) {
                    Text(String(currentCardNum))
                        .spoqaBold(size: 12)
                        .foregroundColor(.primaryColor)
                    Text("/")
                    Text(String(totalCardNum))
                }
                .spoqaRegular(size: 12)
                .foregroundColor(.gray50)
                
                Spacer()
                Text(wordState)
                    .spoqaBold(size: 12)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                    .background(Color.primaryColor)
                    .cornerRadius(1000)
            }
            
            Text("Purpose")
                .spoqaBold(size: 28)
                .foregroundColor(.primaryColor)
            
            Divider()
                .frame(height: 1)
                .foregroundColor(.gray50) // FIXME: color gray30으로 체인지
            
            if isVisiable {
                // TODO: 유동적으로 데이터를 반영하기에는 list나 LazyVStack이 좋을듯, 데이터 구조 잡히면 변경할 예정, row 뷰도 별도로 뺄 예정
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        WordMeaningRow(number: 1, meaning: "(이루고자 하는, 이루어야 할) 목적")
                        
                        WordMeaningRow(number: 2, meaning: "(특정 상황에서 무엇을) 하기 위함, 용도, 의도")
                        
                        WordMeaningRow(number: 3, meaning: "(특정 상황에서 무엇을) 하기 위함, 용도, 의도 하기 위함, 용도, 의도 하기 위함, 용도, 의도 하기 위함, 용도, 의도")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else {
                Text("우측 하단의 아이콘을\n터치하면 뜻을 확인할 수 있어요!")
                    .spoqaRegular(size: 14)
                    .foregroundColor(.gray70)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            }
            
//            Spacer(minLength: 40)
            
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
//    var totalCardNum: Int = 200
//    var currentCardNum: Int = 24
//    var wordState: String = "암기중"// FIXME: 값 변경
//    // Word 모델
//    @State private var isVisiable: Bool = false
    
//    @State var offset: CGFloat = 0
    @State private var translation: CGSize = .zero
    
    @State var endSwipe: Bool = false
    @GestureState var isDragging: Bool = false

    @EnvironmentObject var viewModel: CardViewModel
    var card: CardTestModel
    @Binding var testVal: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            CardView()
            .rotationEffect(
                .degrees(Double(self.translation.width / proxy.size.width * 20)),
                anchor: .bottom
            )
            .offset(x: self.translation.width, y: self.translation.height)
//            .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
            .animation(.interactiveSpring(
                response: 0.5,
                blendDuration: 0.3)
            )
    //                                .offset(x: topOffset, y: offset)
            .gesture(
                DragGesture()
                    .updating($isDragging, body: { value, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        self.translation = value.translation
                        
                        // Fix
                        let width1 = (getRect().width - 50) / 2
                        testVal = max((width1 - self.translation.width) / width1, 0.7)
                        
                        print(self.translation.width, width1, testVal)
    //                                            let translation = value.translation.width
//                        offset = (isDragging ? self.translation.width : .zero)
                    })
                    .onEnded({ value in
                        let width = getRect().width - 50
//                        let translation = value.translation.width
                        self.translation = value.translation
                        
                        // FIX
//                        let width1 = (getRect().width - 50) / 2
//                        testVal = max((width1 - self.translation.width) / width1, 0)
//                        testVal = 1

                        let checkingStatus = (self.translation.width > 0 ? self.translation.width : -self.translation.width)
    //                                endSwipe = true
                        withAnimation {
                            if checkingStatus > (width / 2) {
                                // remoce card
                                self.translation.width = (self.translation.width > 0 ? width : -width) * 2
                                endSwipe = true
                                endSwipeActions()
                            } else {
                                // reset
//                                offset = .zero
                                testVal = 1
                                self.translation = .zero
                            }
                        }
                    })
            )
        }
    }
    
    func endSwipeActions() {
        withAnimation(.none) {
            endSwipe = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = viewModel.dummyData.first {
                let _ = withAnimation {
                    viewModel.dummyData.removeFirst()
                }
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(card: CardTestModel(word: "1"), testVal: .constant(1))
    }
}
