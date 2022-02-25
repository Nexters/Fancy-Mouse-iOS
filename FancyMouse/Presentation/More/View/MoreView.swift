//
//  MoreView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/14.
//

import SwiftUI

enum MoreListRowType: String {
    case makers = "만든사람들"
    case openSourceLicense = "오픈소스 라이선스"
    case versionInfo = "버전 정보"
}

struct MoreListRow: View {
    let type: MoreListRowType
    let versionInfo = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        HStack {
            Text(type.rawValue)
                .spoqaBold(size: 16)
                .foregroundColor(.primaryColor)
            
            Spacer()
            
            if type == .versionInfo {
                Text(self.versionInfo ?? "")
                    .spoqaBold(size: 12)
                    .foregroundColor(.secondaryColor)
                    .padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
                    .background(Color.primaryColor)
                    .cornerRadius(20)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray50)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct TitleView: View {
    var body: some View {
        Text("Fancymouse")
            .foregroundColor(.gray70)
            .spoqaBold(size: 18)
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 53, trailing: 0))
    }
}

struct ProfileView: View {
    var body: some View {
        Image("img_profile_default")
            .frame(width: 48, height: 48, alignment: .center)
        
        // FIXME: 이름 고정값 x
        Text("팬시마우스")
            .spoqaRegular(size: 16)
            .foregroundColor(.gray60)
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 8, trailing: 0))
        
        // FIXME: 이메일 고정값 x
        Text("Fancy@gmail.com")
            .spoqaBold(size: 20)
            .accentColor(.primaryColor)
            .padding(.bottom, 40)
    }
}

struct MoreView: View {
    let moreListRowTypes: [MoreListRowType] = [.makers, .openSourceLicense, .versionInfo]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray30
                .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    TitleView()
                    
                    ProfileView()
                
                    VStack(spacing: 12) {
                        ForEach(moreListRowTypes, id: \.self) { rowType in
                            NavigationLink(destination: Text(rowType.rawValue)) {
                                MoreListRow(type: rowType)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Spacer()
                        Text("로그아웃")
                        Rectangle()
                            .frame(width: 1)
                        Text("회원탈퇴")
                        Spacer()
                    }
                    .frame(height: 18)
                    .padding(.bottom, 60)
                    .spoqaMedium(size: 14)
                    .foregroundColor(.gray50)
                }
                .padding(.horizontal, 24)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
