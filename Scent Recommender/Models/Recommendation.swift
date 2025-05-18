import Foundation

struct Recommendation: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let brand: String
    let imageUrl: String       // ← 用这个字段
    let description: String
    let profile: [String: Double]
    let score: Double

    enum CodingKeys: String, CodingKey {
        case name, brand, imageUrl, description, profile, score
    }
}
