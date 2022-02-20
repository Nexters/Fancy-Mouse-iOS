//
//  MakersView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/19.
//

import SwiftUI

struct MakersView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                Text("Fancymouse를\n만든 사람들")
                    .spoqaRegular(size: 20)
                    .foregroundColor(.white)
                
                //FIXME: 이미지 바뀔 가능성 있음
                Image("makers")
                    .resizable()
                    .scaledToFit()
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 50, trailing: 24))
        }
        .background(Color.primaryDark)
    }
}

struct MakersView_Previews: PreviewProvider {
    static var previews: some View {
        MakersView()
    }
}
