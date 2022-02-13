//
//  LearningIntroView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/13.
//

import SwiftUI

enum LearningState {
    case start
    case end
}

// FIXME: 파일명, 뷰명 변경
struct LearningIntroView: View {
    var state: LearningState = .start
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(state == .start ? "학습을\n시작해 볼까요?" : "학습을\n완료했어요!")
                .spoqaRegular(size: 26)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 40, leading: 24, bottom: 0, trailing: 24))
            
            Spacer(minLength: 24)
            
            Image(state == .start ? "img_study" : "img_study_com")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 0)
            
            Spacer(minLength: 40)
            
            Button {
                // TODO: 학습 시작, 완료 액션 분기처리
                print("학습 시작 or 종료")
            } label: {
                Text(state == .start ? "학습 시작하기" : "학습 다시하기")
                    .spoqaMedium(size: 16)
                    .foregroundColor(.secondaryColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(minHeight: 54, maxHeight: 60)
            .background(Color.primaryColor)
            .cornerRadius(14)
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 40, trailing: 24))
        }
        .frame(maxHeight: .infinity)
        .background(Color.primaryDark)
    }
}

struct LearningIntroView_Previews: PreviewProvider {
    static var previews: some View {
        LearningIntroView()
    }
}
