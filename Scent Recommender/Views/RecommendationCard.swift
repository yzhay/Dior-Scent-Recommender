import SwiftUI

struct RecommendationCard: View {
    let rec: Recommendation

    var body: some View {
        VStack(spacing: 12) {
            // Check if the imageUrl starts with "http" to determine if it's a remote URL
            if rec.imageUrl.hasPrefix("http") {
                // Handle remote URL images
                AsyncImage(url: URL(string: rec.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 180)
                    case .success(let img):
                        img.resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .foregroundColor(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Handle local image names
                Image(rec.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Text(rec.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Theme.textPrimary)

            Text(rec.brand)
                .font(.subheadline)
                .foregroundColor(Theme.textPrimary.opacity(0.7))

            Text(rec.description)
                .font(.body)
                .foregroundColor(Theme.textPrimary.opacity(0.8))
                .lineLimit(3)

            HStack {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(Theme.accent)
                Text(String(format: "%.1f", rec.score))
                    .font(.caption)
                    .foregroundColor(Theme.textPrimary)
                Spacer()
            }
        }
        .diorCardStyle()
    }
}

struct RecommendationCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationCard(rec: Recommendation(
            name: "J'adore",
            brand: "Dior",
            imageUrl: "jadore",
            description: "A radiant floral bouquet…",
            profile: ["floral": 0.8],
            score: 4.7
        ))
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Theme.background)
    }
}
