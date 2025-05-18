import SwiftUI

struct RecommendView: View {
    let rec: Recommendation

    var body: some View {
        VStack(spacing: 24) {
            RecommendationCard(rec: rec)

            NavigationLink("View Nearby Stores") {
                StoreListView()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 16)
        }
        .padding()
        .navigationTitle("Your Recommendation")
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecommendView(rec: Recommendation(
                name: "J'adore",
                brand: "Dior",
                imageUrl: "jadore",
                description: "A radiant floral bouquet…",
                profile: ["floral": 0.8],
                score: 4.7
            ))
        }
    }
}
