// HomeView.swift

import SwiftUI

struct HomeView: View {
    // 使用 AuthViewModel 管理登录状态
    @EnvironmentObject private var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            Group {
                if authVM.isAuthenticated {
                    // 已登录就直接进 Quiz 流程
                    QuizView()
                } else {
                    // 否则先登录/注册
                    LoginView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
