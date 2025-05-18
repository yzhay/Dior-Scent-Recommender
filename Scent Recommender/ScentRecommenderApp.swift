import SwiftUI
import CoreData

@main
struct ScentRecommenderApp: App {
    @StateObject private var authVM = AuthViewModel()

    init() {
        // UINavigationBar 全局样式
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = UIColor(Theme.background)
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(Theme.textPrimary)]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Theme.textPrimary)]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().tintColor = UIColor(Theme.accent)
        
        // TabBar／SegmentedControl 如果有也可以类似设置
    }

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .accentColor(Theme.accent)
                .environmentObject(authVM)
                .environment(
                    \.managedObjectContext,
                    PersistenceController.shared.container.viewContext
                )
        }
    }
}
