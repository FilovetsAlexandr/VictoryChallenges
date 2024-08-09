//
//  ChallengeViewModel.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import Combine
import SwiftUI

class ChallengeViewModel: ObservableObject {
    @Published var players: Int = 2
    @Published var playerNames: [String] = []
    @Published var selectedCategory: ChallengeCategory?
    @Published var currentChallenge: Challenge?
    @Published var score: [Int] = []

    let challenges: [Challenge] = [
        // Physical Challenges
        Challenge(category: .physical, description: "Do 20 squats"),
        Challenge(category: .physical, description: "Do 20 push-ups"),
        Challenge(category: .physical, description: "Do 20 forward lunges"),
        Challenge(category: .physical, description: "Do 10 jump squats"),
        Challenge(category: .physical, description: "Do 20 side lunges"),
        // Riddles
        Challenge(category: .riddles, description: "What can be broken without being touched? (A promise)"),
        Challenge(category: .riddles, description: "I can be thrown but not held. What am I? (A glance)"),
        Challenge(category: .riddles, description: "I'm always hungry, I always want to eat, but if you feed me, I die. What am I? (Fire)"),
        Challenge(category: .riddles, description: "What is always in front of you but can't be seen? (The future)"),
        Challenge(category: .riddles, description: "What can you catch but not throw? (A cold)"),
        // Jokes
        Challenge(category: .jokes, description: "Call a friend and say you accidentally sent them a very important message by mistake."),
        Challenge(category: .jokes, description: "Text a friend saying you won a large sum in the lottery and plan to buy an island"),
        Challenge(category: .jokes, description: "Start a bizarre phone conversation: No, sorry, I can't become an astronaut, I'm allergic to space"),
        Challenge(category: .jokes, description: "Ask someone to say a long or difficult word, then keep asking them to repeat it, pretending you didn't hear"),
        Challenge(category: .jokes, description: "Start asking simple riddles to your friends, but every time they give the correct answer, say it's wrong."),
        // Personal Questions
        Challenge(category: .personalQuestions, description: "What place in the world do you dream of visiting and why?"),
        Challenge(category: .personalQuestions, description: "What quality do you value most in people?"),
        Challenge(category: .personalQuestions, description: "What's the bravest thing you've ever done?"),
        Challenge(category: .personalQuestions, description: "If you could change one event in your life, what would it be?"),
        Challenge(category: .personalQuestions, description: "What's your favorite season and why?"),
        // Friends Knowledge
        Challenge(category: .friendsKnowledge, description: "Who among us is the bravest?"),
        Challenge(category: .friendsKnowledge, description: "What moment in our friendship do you consider the most memorable?"),
        Challenge(category: .friendsKnowledge, description: "What one quality do you value most in each of us?"),
        Challenge(category: .friendsKnowledge, description: "If you could spend one day as one of us, who would you choose and why?"),
        Challenge(category: .friendsKnowledge, description: "If you could describe each of us in one word, what would it be?")
    ]

    var askedChallenges: [Challenge] = []
    var currentPlayerIndex: Int = 0

    init() {
        resetGame()
    }

    func resetGame() {
        score = Array(repeating: 0, count: players)
        askedChallenges.removeAll()
        currentPlayerIndex = min(currentPlayerIndex, players - 1)
        selectRandomChallenge()
    }

    func selectRandomChallenge() {
        guard let selectedCategory = selectedCategory else { return }
        let filteredChallenges = challenges.filter { challenge in
            challenge.category == selectedCategory && !askedChallenges.contains(where: { $0.description == challenge.description })
        }

        if let randomChallenge = filteredChallenges.randomElement() {
            currentChallenge = randomChallenge
            askedChallenges.append(randomChallenge)
        } else {
            currentChallenge = nil
        }
    }

    func completeChallenge(success: Bool) {
        guard players > 0, !score.isEmpty, currentPlayerIndex < score.count else {
            print("Error: Invalid player index or score array")
            return
        }
        if success {
            score[currentPlayerIndex] += 1
        }
        nextPlayer()
        selectRandomChallenge()
    }

    func updatePlayers(to newCount: Int) {
        guard newCount > 0 else {
            print("Error: Number of players must be greater than zero")
            return
        }
        players = newCount
        if currentPlayerIndex >= newCount {
            currentPlayerIndex = newCount - 1
        }
        resetGame()
    }

    private func nextPlayer() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players
    }

    func restartViewModel() {
        players = 2
        playerNames = []
        selectedCategory = nil
        currentChallenge = nil
        score = []
        askedChallenges = []
        currentPlayerIndex = 0
    }
}
