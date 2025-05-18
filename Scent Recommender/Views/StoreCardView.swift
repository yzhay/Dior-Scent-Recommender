import SwiftUI   // ← Make sure this is here!

struct StoreCardView: View {
    let store: Store
    @ObservedObject var favVM: FavoritesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(store.name)
                    .font(.headline)
                    .foregroundColor(Theme.textPrimary)
                Spacer()
                Button {
                    favVM.toggle(store: store)
                } label: {
                    Image(systemName: favVM.isFavorite(store) ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundColor(Theme.accent)
                }
            }

            Text("Stock: \(store.stock)")
                .font(.subheadline)
                .padding(6)
                .background(
                    store.stock > 10 ? Color.green :
                    store.stock > 0  ? Color.yellow : Color.red
                )
                .cornerRadius(4)
                .foregroundColor(.white)

            Text("Hours: \(store.hours)")
                .font(.subheadline)
                .foregroundColor(Theme.textPrimary.opacity(0.8))

            Text("Crowd: \(store.crowdDescription)")
                .font(.subheadline)
                .foregroundColor(Theme.textPrimary.opacity(0.8))

            Button {
                if let url = URL(string: "tel://\(store.phone)"),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "phone.fill")
                    Text("Call")
                }
                .font(.subheadline)
                .foregroundColor(Theme.accent)
            }
        }
        .padding()
        .background(Theme.surface)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct StoreCardView_Previews: PreviewProvider {  // ← And here!
    static var previews: some View {
        let example = Store(
            id: "westfield",
            name: "Westfield Sydney",
            city: "Sydney",
            stock: 15,
            hours: "9am - 9pm",
            phone: "0212345678",
            crowd: "Low",
            latitude: -33.870452,
            longitude: 151.207047
        )
        StoreCardView(store: example, favVM: FavoritesViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

