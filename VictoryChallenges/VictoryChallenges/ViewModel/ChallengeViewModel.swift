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
    @Published var gameCompleted: Bool = false
    
    let challenges: [Challenge] = [
        // Физические испытания
        Challenge(category: .physical, description: "Сделай 20 приседаний"),
        Challenge(category: .physical, description: "Сделай 20 отжиманий"),
        Challenge(category: .physical, description: "Сделай 20 выпадов вперед"),
        Challenge(category: .physical, description: "Сделай 10 приседаний с прыжком"),
        Challenge(category: .physical, description: "Сделай 20 выпадов в стороны"),
        // Загадки
        Challenge(category: .riddles, description: "Что можно разбить, не касаясь его? (Обещание)"),
        Challenge(category: .riddles, description: "Меня можно бросить, но нельзя удержать. Что это? (Взгляд)"),
        Challenge(category: .riddles, description: "Я всегда голоден, я всегда хочу есть, но если меня покормить, я умру. Что это? (Огонь)"),
        Challenge(category: .riddles, description: "Что всегда перед вами, но не видно? (Будущее)"),
        Challenge(category: .riddles, description: "Что можно поймать, но нельзя бросить? (Простуда)"),
        // Шутки
        Challenge(category: .jokes, description:
                    "Позвони другу и скажи, что случайно отправил ему очень важное сообщение по ошибке. Попроси его срочно проверить и перезвонить тебе"),
        Challenge(category: .jokes, description:
                    "Напиши другу, что выиграл крупную сумму в лотерею и планируешь купить остров"),
        Challenge(category: .jokes, description:
                    "Начните необычный разговор по телефону: Нет, извините, я не могу стать космонавтом, у меня есть аллергия на космос"),
        Challenge(category: .jokes, description:
                    "Попросите кого-то сказать длинное или сложное слово, а затем постоянно просите его повторить это слово, делая вид, что вы не расслышали"),
        Challenge(category: .jokes, description:
                    "Начните задавать простые загадки своим друзьям, но каждый раз, когда они дают правильный ответ, говорите, что это неправильно."),
        // Личностные вопросы
        Challenge(category: .personalQuestions, description: "Какое место в мире ты мечтаешь посетить и почему?"),
        Challenge(category: .personalQuestions, description: "Какое качество ты больше всего ценишь в людях?"),
        Challenge(category: .personalQuestions, description: "Какой самый смелый поступок ты совершил в своей жизни?"),
        Challenge(category: .personalQuestions, description: "Если бы у тебя была возможность изменить одно событие в своей жизни, что бы это было?"),
        Challenge(category: .personalQuestions, description: "Какое твое любимое время года и почему?"),
        // Познание друзей
        Challenge(category: .friendsKnowledge, description: "Кто из нас самый смелый?"),
        Challenge(category: .friendsKnowledge, description: "Какой момент в нашей дружбе ты считаешь самым запоминающимся?"),
        Challenge(category: .friendsKnowledge, description: "Какое одно качество ты ценишь больше всего в каждом из нас?"),
        Challenge(category: .friendsKnowledge, description: "Если бы ты мог провести один день в роли одного из нас, кого бы ты выбрал и почему?"),
        Challenge(category: .friendsKnowledge, description: "Если бы ты мог описать каждого из нас одним словом, что бы это было?")
    ]
    
    var askedChallenges: [Challenge] = []
    var currentPlayerIndex: Int = 0
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        score = Array(repeating: 0, count: players)
        askedChallenges.removeAll()
        gameCompleted = false
        selectRandomChallenge()
    }
    
    func selectRandomChallenge() {
        guard let selectedCategory = selectedCategory else { return }

        // Фильтруем вызовы по выбранной категории и исключаем уже заданные вызовы
        let filteredChallenges = challenges.filter { challenge in
            challenge.category == selectedCategory && !askedChallenges.contains(where: { $0.description == challenge.description })
        }

        if let randomChallenge = filteredChallenges.randomElement() {
            currentChallenge = randomChallenge
            askedChallenges.append(randomChallenge)
        } else {
            currentChallenge = nil // Все вопросы из категории были заданы
        }
    }

    
    func completeChallenge(success: Bool) {
        if success {
            score[currentPlayerIndex] += 1
        }
        nextPlayer()
        selectRandomChallenge()
    }
    
    private func nextPlayer() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players
    }
}
