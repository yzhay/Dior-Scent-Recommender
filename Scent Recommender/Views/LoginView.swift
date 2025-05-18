import SwiftUI

struct LoginView: View {
    // MARK: — State
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer().frame(height: 80)

                    // 标题
                    Text("Welcome to Dior")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Theme.textPrimary)
                        .padding(.horizontal, 40)

                    // 用户名
                    TextField("Username", text: $username)
                        .padding()
                        .background(Theme.surface)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

                    // 密码
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Theme.surface)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

                    // 登录 & 注册 按钮
                    HStack(spacing: 16) {
                        Button("Login") {
                            if !username.isEmpty && !password.isEmpty {
                                isLoggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        
                        Button("Sign Up") {
                            // 这里可以接入注册逻辑，暂时也当登录
                            if !username.isEmpty && !password.isEmpty {
                                isLoggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                    
                    // 隐藏的 NavigationLink，用于自动跳转
                    NavigationLink(
                        destination: QuizView(),
                        isActive: $isLoggedIn
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter both username and password.")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
