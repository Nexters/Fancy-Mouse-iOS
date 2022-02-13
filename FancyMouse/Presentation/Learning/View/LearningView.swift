//
//  LearningView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/13.
//

import SwiftUI

struct LearningView: View {
    @State var checkIsTapped = false
    @State var xmarkIsTapped = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // TODO: 카드뷰 개발 중, 개발 완료후 교체 예정
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(30)
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 36, trailing: 24))
            
            HStack {
                HStack(spacing: 5) {
                    Image("check")
                        .frame(width: 13, height: 16)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: checkIsTapped ? 8 : 16))
                    if checkIsTapped {
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
                        checkIsTapped.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.interactiveSpring()) {
                            checkIsTapped.toggle()
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    if xmarkIsTapped {
                        Text("미암기")
                            .spoqaBold(size: 16)
                            .padding(.leading, 16)
                    }
                    
                    Image("xmark")
                        .frame(width: 16, height: 16)
                        .padding(EdgeInsets(top: 16, leading: xmarkIsTapped ? 8 : 16, bottom: 16, trailing: 16))
                }
                .background(Color.folder07)
                .foregroundColor(.white)
                .cornerRadius(16)
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        xmarkIsTapped.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.interactiveSpring()) {
                            xmarkIsTapped.toggle()
                        }
                    }
                }
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
