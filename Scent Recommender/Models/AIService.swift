import Foundation

protocol AIServiceProtocol {
    func fetchRecommendations(for prefs: [String]) async throws -> [Recommendation]
}

class AIService: AIServiceProtocol {
    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!
    private let apiKey = "YOUR_OPENAI_API_KEY"

    func fetchRecommendations(for prefs: [String]) async throws -> [Recommendation] {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = """
            You are a perfume expert specialized in Dior. \
            Given user preferences: \(prefs.joined(separator: ", ")), \
            recommend 3 Dior perfumes. For each, return a JSON object with:
            1) name (Dior perfume name)
            2) description (elegant description)
            3) profile (scent notes as percentages)
            4) topNotes (array of notes)
            5) heartNotes (array of notes)
            6) baseNotes (array of notes)
            7) season (best season to wear)
            8) occasion (best occasions)
            9) price (price range)
            10) score (match score 0-10)
            Format as proper JSON array.
        """
        
        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "system", "content": "You are a Dior perfume expert."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        struct Choice: Decodable {
            struct Message: Decodable {
                let content: String
            }
            let message: Message
        }
        struct Response: Decodable {
            let choices: [Choice]
        }
        
        let resp = try JSONDecoder().decode(Response.self, from: data)
        let text = resp.choices.first!.message.content
        
        let jsonData = Data(text.utf8)
        let recs = try JSONDecoder().decode([Recommendation].self, from: jsonData)
        return recs
    }
}
