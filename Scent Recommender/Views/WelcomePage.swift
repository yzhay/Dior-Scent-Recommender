import SwiftUI

struct WelcomePage: View {
    // MARK: - State
    @State private var current = 0
    @State private var animateLight = false
    @State private var showLogin = false

    // 你在 Assets.xcassets 中添加的香水图片名称
    private let images = ["jadore", "missdior", "sauvage"]

    var body: some View {
        ZStack {
            // 全屏背景图
            Image("welcome_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 半透明黑色叠加，增强文字可读
            Color.black.opacity(0.2)
                .ignoresSafeArea()

            // 动态光斑1
            Circle()
                .fill(Theme.accent.opacity(0.3))
                .frame(width: 300, height: 300)
                .blur(radius: 60)
                .offset(x: animateLight ? 150 : -150,
                        y: animateLight ? -200 : 200)
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true),
                           value: animateLight)

            // 动态光斑2
            Circle()
                .fill(Theme.accent.opacity(0.2))
                .frame(width: 200, height: 200)
                .blur(radius: 80)
                .offset(x: animateLight ? -100 : 100,
                        y: animateLight ? 200 : -100)
                .animation(.easeInOut(duration: 8).repeatForever(autoreverses: true),
                           value: animateLight)

            // 主要内容
            VStack(spacing: 24) {
                Spacer().frame(height: 60)

                // Dior Logo
                Image("DIOR")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)

                // 3D 轮播 TabView
                TabView(selection: $current) {
                    ForEach(images.indices, id: \.self) { idx in
                        Image(images[idx])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 220)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                            .rotation3DEffect(
                                .degrees(Double(idx - current) * 20),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .tag(idx)
                            .padding(.horizontal, 40)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 240)

                // 自定义分页指示器
                HStack(spacing: 8) {
                    ForEach(images.indices, id: \.self) { idx in
                        Circle()
                            .fill(idx == current
                                  ? Theme.accent
                                  : Theme.surface.opacity(0.6))
                            .frame(width: idx == current ? 12 : 8,
                                   height: idx == current ? 12 : 8)
                            .animation(.spring(), value: current)
                    }
                }

                // 分两行标题
                Text("Discover Your Signature\nDior Fragrance")
                    .font(.system(size: 28, weight: .semibold, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 30)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)

                // 副标题
                Text("Swipe to explore our classics and start your personalized quiz now.")
                    .font(.system(size: 17, weight: .regular, design: .serif))
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 40)
                    .minimumScaleFactor(0.75)

                Spacer()

                // 开始按钮：全屏 Modal 跳转 LoginView
                Button(action: {
                    showLogin = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
                .fullScreenCover(isPresented: $showLogin) {
                    LoginView()
                }

                Spacer().frame(height: 40)
            }
        }
        .statusBarHidden(true)
        .onAppear {
            animateLight = true
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
