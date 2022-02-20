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
        HStack(spacing: 6) {
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
                ScrollView {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        WordMeaningRow(number: 1, meaning: "(이루고자 하는, 이루어야 할) 목적")
                        
                        WordMeaningRow(number: 2, meaning: "(특정 상황에서 무엇을) 하기 위함, 용도, 의도")
                        
                        WordMeaningRow(number: 3, meaning: "(특정 상황에서 무엇을) 하기 위함, 용도, 의도 하기 위함, 용도, 의도 하기 위함, 용도, 의도 하기 위함, 용도, 의도")
                    }
                    .frame(maxWidth: .infinity)
                }
            } else {
                Text("우측 하단의 아이콘을\n터치하면 뜻을 확인할 수 있어요!")
                    .spoqaRegular(size: 14)
                    .foregroundColor(.gray70)
                    .multilineTextAlignment(.center)
            }
            
            Spacer(minLength: 40)
            
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
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
