import SwiftUI

struct LaunchView: View {
    @State private var isCoverDone = false
    var body: some View {
        Group {
            if !isCoverDone {
                // 封面：纯白 + DIOR logo
                ZStack {
                    Color.white.ignoresSafeArea()
                    Image("DIOR")  // 你的 Dior Logo 资源名
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isCoverDone = true
                    }
                }
            } else {
                NavigationView {
                    WelcomePage()
                }
            }
        }
    }
}
