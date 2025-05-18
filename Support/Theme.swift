// Theme.swift
import SwiftUI

struct Theme {
    // 背景灰
    static let background = Color(red: 229/255, green: 229/255, blue: 229/255)
    // 卡片／白底
    static let surface = Color.white
    // 文字主色 深灰
    static let textPrimary = Color(red: 51/255, green: 51/255, blue: 51/255)
    // 金色点缀 Dior 金
    static let accent = Color(red: 212/255, green: 175/255, blue: 55/255)
}

// MARK: - ButtonStyle

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Theme.accent)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
    }
}

// MARK: - Card Modifier

struct DiorCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Theme.surface)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func diorCardStyle() -> some View {
        modifier(DiorCard())
    }
}
