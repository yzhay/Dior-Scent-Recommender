import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var selectedOption: AnswerOption?
    @Published var recommendations: [Recommendation] = []

    /// 用来暂存所有题目的回答
    private var answers: [Int: AnswerOption] = [:]

    init() {
        loadQuestions()
    }

    private func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "quizData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Question].self, from: data)
        else {
            print("❌ 无法加载 quizData.json")
            return
        }
        questions = decoded
    }

    /// 当前正在展示的题目
    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    /// 用户选中某个选项
    func select(option: AnswerOption) {
        selectedOption = option
        if let q = currentQuestion {
            answers[q.id] = option
        }
    }

    /// 点击"Next"或"Submit"
    func submit() {
        guard selectedOption != nil else { return }
        if currentIndex < questions.count - 1 {
            // 进入下一题
            currentIndex += 1
            selectedOption = nil
        } else {
            // 最后一题，生成多款推荐
            makeRecommendations()
        }
    }

    /// 根据第 3 题（scent）生成三款推荐
    private func makeRecommendations() {
        guard let scentAnswerID = answers[3]?.id else { return }
        let mapping: [Int: [Recommendation]] = [
            1: [ // Floral
                Recommendation(
                    name: "J'adore", brand: "Dior",
                    imageUrl: "jadore",
                    description: "A radiant floral bouquet of ylang-ylang and Damascus rose.",
                    profile: ["floral": 0.8], score: 4.7
                ),
                Recommendation(
                    name: "Miss Dior", brand: "Dior",
                    imageUrl: "missdior",
                    description: "A classic chypre rose fragrance with patchouli undertones.",
                    profile: ["floral": 0.7], score: 4.5
                ),
                Recommendation(
                    name: "Blooming Bouquet", brand: "Dior",
                    imageUrl: "bloomingbouquet",
                    description: "Elegant floral heart with a delicate finish.",
                    profile: ["floral": 0.9], score: 4.6
                )
            ],
            2: [ // Woody
                Recommendation(
                    name: "Poison Girl", brand: "Dior",
                    imageUrl: "poisongirl",
                    description: "Vibrant woody fragrance with a bitter almond twist.",
                    profile: ["woody": 0.8], score: 4.4
                ),
                Recommendation(
                    name: "Dior Homme", brand: "Dior",
                    imageUrl: "diorman",
                    description: "Modern woody musk with vetiver accents.",
                    profile: ["woody": 0.9], score: 4.3
                ),
                Recommendation(
                    name: "Fève Délicieuse", brand: "Dior",
                    imageUrl: "feve",
                    description: "Warm gourmand woody blend with tonka bean.",
                    profile: ["woody": 0.7], score: 4.2
                )
            ],
            3: [ // Fresh
                Recommendation(
                    name: "Sauvage", brand: "Dior",
                    imageUrl: "sauvage",
                    description: "Fresh spicy citrus with ambroxan clarity.",
                    profile: ["fresh": 0.9], score: 4.8
                ),
                Recommendation(
                    name: "Dior Homme", brand: "Dior",
                    imageUrl: "diorman",
                    description: "Modern woody musk with vetiver accents.",
                    profile: ["woody": 0.9], score: 4.3
                ),
                Recommendation(
                    name: "Eau Savage", brand: "Dior",
                    imageUrl: "eausavage",
                    description: "Classic citrus-fresh heart with woody base.",
                    profile: ["fresh": 0.7], score: 4.4
                )
            ],
            4: [ // Oriental
                Recommendation(
                    name: "Hypnotic Poison", brand: "Dior",
                    imageUrl: "hypnotic",
                    description: "Warm gourmand vanilla with almond and jasmine.",
                    profile: ["oriental": 0.9], score: 4.6
                ),
                Recommendation(
                    name: "Poison", brand: "Dior",
                    imageUrl: "poisonclassic",
                    description: "Deep spicy oriental with tuberose and honey.",
                    profile: ["oriental": 0.8], score: 4.3
                ),
                Recommendation(
                    name: "Ambre Nuit", brand: "Dior",
                    imageUrl: "ambre",
                    description: "Smoky amber with rose undercurrents.",
                    profile: ["oriental": 0.7], score: 4.2
                )
            ]
        ]
        recommendations = mapping[scentAnswerID] ?? []
    }
}
