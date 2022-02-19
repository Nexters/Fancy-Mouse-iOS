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

struct LearningView: View {
    @State private var checkIsTapped = false
    @State private var xmarkIsTapped = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // TODO: 카드뷰 개발 중, 개발 완료후 교체 예정
            
            CardView()
                .padding(EdgeInsets(top: 40, leading: 24, bottom: 60, trailing: 24))
            
            HStack {
                CompleteButton(isTapped: $checkIsTapped)
                Spacer()
                IncompleteButton(isTapped: $xmarkIsTapped)
            }
            .padding(EdgeInsets(top: 0, leading: 60, bottom: 24, trailing: 60))
        }
        .background(Color.primaryDark)
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
