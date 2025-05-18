// ViewModels/AuthViewModel.swift
import Foundation

class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false

    func login() {
        let savedPw = UserDefaults.standard.string(forKey: username)
        if savedPw == password {
            isAuthenticated = true
        }
    }

    func signup() {
        UserDefaults.standard.set(password, forKey: username)
        isAuthenticated = true
    }
}
