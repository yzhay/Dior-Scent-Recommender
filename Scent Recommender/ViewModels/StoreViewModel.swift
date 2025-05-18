import Foundation

class StoreViewModel: ObservableObject {
    @Published var stores: [Store] = []
    @Published var selectedCity: String = "All Australia"

    init() {
        loadStores()
    }

    private func loadStores() {
        // 从主 Bundle 中查找 stores.json
        guard let url = Bundle.main.url(forResource: "stores", withExtension: "json") else {
            print("❌ stores.json not found in bundle!")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Store].self, from: data)
            print("✅ Loaded \(decoded.count) stores from JSON")
            DispatchQueue.main.async {
                self.stores = decoded
            }
        } catch {
            print("❌ JSON decode error:", error)
        }
    }
}
