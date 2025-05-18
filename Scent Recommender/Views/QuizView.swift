import SwiftUI

struct QuizView: View {
    @StateObject private var vm = QuizViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - 滚动内容
                ScrollView {
                    VStack(spacing: 24) {
                        // 问题 & 选项
                        if let q = vm.currentQuestion {
                            Text(q.question)
                                .font(.headline)
                                .foregroundColor(Theme.textPrimary)
                                .padding(.horizontal)

                            ForEach(q.options) { opt in
                                Button {
                                    vm.select(option: opt)
                                } label: {
                                    HStack {
                                        Image(opt.imageName)
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .clipShape(Circle())
                                        Text(opt.text)
                                            .foregroundColor(Theme.textPrimary)
                                        Spacer()
                                        if vm.selectedOption?.id == opt.id {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Theme.accent)
                                        }
                                    }
                                    .padding()
                                    .background(Theme.surface)
                                    .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal)
                            }

                            Button(vm.currentIndex < vm.questions.count - 1 ? "Next" : "Submit") {
                                vm.submit()
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .padding(.horizontal)
                        }

                        // 多款推荐
                        if !vm.recommendations.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(vm.recommendations) { rec in
                                        RecommendationCard(rec: rec)
                                            .frame(width: 300)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 320)
                        }

                        Spacer()
                            .frame(height: 16) // 给底部按钮留点空隙
                    }
                    .padding(.top)
                }
                .background(Theme.background)
                
                // MARK: - 底部固定按钮
                if !vm.recommendations.isEmpty {
                    NavigationLink(destination: StoreListView()) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text("See Nearby Stores")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accent)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                }
            }
            .navigationTitle("Quiz")
            .accentColor(Theme.accent)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
