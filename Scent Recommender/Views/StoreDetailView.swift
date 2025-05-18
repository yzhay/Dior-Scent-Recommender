import SwiftUI   // ← Make sure this is here!

struct StoreDetailView: View {
    let store: Store
    @ObservedObject var favVM: FavoritesViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(store.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.center)

            HStack {
                Text("Stock: \(store.stock)")
                    .padding(8)
                    .background(
                        store.stock > 10 ? Color.green :
                        store.stock > 0  ? Color.yellow : Color.red
                    )
                    .cornerRadius(4)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    favVM.toggle(store: store)
                } label: {
                    Image(systemName: favVM.isFavorite(store) ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(Theme.accent)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Hours: \(store.hours)")
                Text("Crowd: \(store.crowdDescription)")
            }
            .font(.subheadline)
            .foregroundColor(Theme.textPrimary.opacity(0.8))

            Button {
                if let url = URL(string: "tel://\(store.phone)"),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Call Store")
                }
                .font(.subheadline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Theme.accent)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .background(Theme.background.ignoresSafeArea(edges: .bottom))
    }
}

struct StoreDetailView_Previews: PreviewProvider {  // ← And here!
    static var previews: some View {
        StoreDetailView(
            store: Store(
                id: "qvb",
                name: "Queen Victoria Building",
                city: "Sydney",
                stock: 8,
                hours: "10am - 6pm",
                phone: "0287654321",
                crowd: "Moderate",
                latitude: -33.8731,
                longitude: 151.2069
            ),
            favVM: FavoritesViewModel()
        )
    }
}

