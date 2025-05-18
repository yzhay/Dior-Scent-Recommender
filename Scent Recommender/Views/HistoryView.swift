import SwiftUI

struct HistoryView: View {
    @StateObject private var favVM = FavoritesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if favVM.favorites.isEmpty {
                        Text("No favorites yet.")
                            .font(.body)
                            .foregroundColor(Theme.textPrimary.opacity(0.7))
                            .padding()
                    } else {
                        ForEach(favVM.favorites) { store in
                            StoreCardView(store: store, favVM: favVM)
                                .diorCardStyle()
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Theme.background.ignoresSafeArea())
            .navigationTitle("Favorites")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
