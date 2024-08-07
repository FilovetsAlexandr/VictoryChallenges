//
//  ChallengeCategory.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import Foundation

enum ChallengeCategory: String, Identifiable, CaseIterable {
    case physical = "Физические вызовы"
    case riddles = "Загадки"
    case jokes = "Шутки и розыгрыши"
    case personalQuestions = "Личностные вопросы"
    case friendsKnowledge = "Познание друзей"

    var id: String { self.rawValue }
}

struct Challenge: Identifiable {
    let id = UUID()
    let category: ChallengeCategory
    let description: String
}

