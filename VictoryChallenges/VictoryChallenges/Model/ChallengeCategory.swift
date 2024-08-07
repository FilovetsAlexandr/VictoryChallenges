//
//  ChallengeCategory.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import Foundation

enum ChallengeCategory: String, Identifiable, CaseIterable {
    case physical = "Physical Challenges"
    case riddles = "Riddles"
    case jokes = "Jokes and Pranks"
    case personalQuestions = "Personal Questions"
    case friendsKnowledge = "Friends Knowledge"

    var id: String { self.rawValue }
}

struct Challenge: Identifiable {
    let id = UUID()
    let category: ChallengeCategory
    let description: String
}

