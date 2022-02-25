//
//  MakersView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/19.
//

import SwiftUI

struct MakersView: View {
    var body: some View {
        ZStack {
            Color.primaryDark
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    Text("Fancymouse를\n만든 사람들")
                        .spoqaRegular(size: 20)
                        .foregroundColor(.white)
                    Image("makers")
                        .resizable()
                        .scaledToFit()
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 50, trailing: 24))
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct MakersView_Previews: PreviewProvider {
    static var previews: some View {
        MakersView()
    }
}
