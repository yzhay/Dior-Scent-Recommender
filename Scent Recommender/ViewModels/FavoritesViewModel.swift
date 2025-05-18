import Foundation

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [Store] = []

    func toggle(store: Store) {
        if let idx = favorites.firstIndex(where: { $0.id == store.id }) {
            favorites.remove(at: idx)
        } else {
            favorites.append(store)
        }
    }

    func isFavorite(_ store: Store) -> Bool {
        favorites.contains { $0.id == store.id }
    }
}
