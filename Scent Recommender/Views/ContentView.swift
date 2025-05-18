// Views/ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        if authVM.isAuthenticated {
            QuizView()
        } else {
            LoginView()
        }
    }
}
