// Models/Question.swift
import Foundation

struct Question: Identifiable, Codable {
    let id: Int
    let question: String
    let options: [AnswerOption]
}
