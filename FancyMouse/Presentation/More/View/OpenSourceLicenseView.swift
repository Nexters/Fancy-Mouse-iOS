//
//  OpenSourceLicenseView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/19.
//

import SwiftUI

struct OpenSourceLicenseView: View {
    let openSourceList: String = {
        guard let path = Bundle.main.path(forResource: "OpenSourceLicense", ofType: "txt"),
              let openSourceList = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        else { return "" }
        return openSourceList
    }()
    
    var body: some View {
        ZStack {
            Color.primaryDark
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Open Source License")
                    .lineLimit(nil)
                    .spoqaBold(size: 24)
                    .padding(.top, 24)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                
                ScrollView {
                    Text(openSourceList)
                        .padding(.vertical, 20)
                }
                .spoqaRegular(size: 14)
                .foregroundColor(.gray50)
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .padding(.horizontal, 24)
        }
    }
}

struct OpenSourceLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceLicenseView()
    }
}
