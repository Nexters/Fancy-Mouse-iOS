//
//  MoreView.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/14.
//

import Combine
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
    let userName = UserManager.userName ?? ""
    let userEmail = UserManager.userEmail ?? ""
    
    var body: some View {
        Image("img_profile_default")
            .frame(width: 48, height: 48, alignment: .center)
        
        Text(userName)
            .spoqaRegular(size: 16)
            .foregroundColor(.gray60)
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 8, trailing: 0))
        
        Text(userEmail)
            .spoqaBold(size: 20)
            .accentColor(.primaryColor)
            .padding(.bottom, 40)
    }
}

// TODO: 파일 위치 이동
final class MoreViewViewModel {
    var bag = Set<AnyCancellable>()
    let signOutWasTapped = PassthroughSubject<Void, Never>()
    let withdrawalWasTapped = PassthroughSubject<Void, Never>()
    let signOutSignal = PassthroughSubject<Void, Never>()
    
    init() {
        bindAction()
    }
    
    private func bindAction() {
        signOutWasTapped
            .sink { [weak self] _ in
                self?.cleanUpUserData()
                self?.signOutSignal.send()
            }
            .store(in: &bag)
        
        withdrawalWasTapped
            .sink { [weak self] _ in
                self?.cleanUpUserData()
                // TODO: 회원 정보 삭제 추가
                self?.signOutSignal.send()
            }
            .store(in: &bag)
    }
    
    private func cleanUpUserData() {
        UserManager.userID = nil
        UserManager.userName = nil
        UserManager.userEmail = nil
    }
}

struct MoreView: View {
    let viewModel: MoreViewViewModel
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
                            NavigationLink(destination: test(type: rowType)) {
                                MoreListRow(type: rowType)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button {
                            viewModel.signOutWasTapped.send()
                        } label: {
                            Text("로그아웃")
                        }

                        Rectangle()
                            .frame(width: 1)
            
                        Button {
                            viewModel.withdrawalWasTapped.send()
                        } label: {
                            Text("회원탈퇴")
                        }
                        
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
        .onReceive(viewModel.signOutSignal) { _ in
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            keyWindow?.rootViewController = WalkthroughMainViewController()
        }
    }
    
    @ViewBuilder func test(type: MoreListRowType) -> some View {
        switch type {
        case .makers:
            MakersView()
        case .openSourceLicense:
            OpenSourceLicenseView()
        case .versionInfo:
            Text("")
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView(viewModel: MoreViewViewModel())
    }
}
