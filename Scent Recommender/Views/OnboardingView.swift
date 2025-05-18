import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarding: Bool
    
    var body: some View {
        TabView {
            OnboardingPage(
                title: "Welcome to Scent AI",
                description: "Your personal fragrance curator powered by artificial intelligence",
                imageName: "sparkles",
                isLastPage: false
            )
            
            OnboardingPage(
                title: "Smart Recommendations",
                description: "Get personalized perfume suggestions based on your preferences using advanced AI technology",
                imageName: "wand.and.stars",
                isLastPage: false
            )
            
            OnboardingPage(
                title: "Track Your Journey",
                description: "Keep track of your fragrance preferences and discover your perfect scent over time",
                imageName: "chart.line.uptrend.xyaxis",
                isLastPage: true
            ) {
                isOnboarding = false
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    let isLastPage: Bool
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding()
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .shadow(radius: 10)
                )
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.title)
                    .bold()
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            if isLastPage {
                Button {
                    action?()
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal, 32)
                .padding(.bottom)
            }
        }
    }
} 