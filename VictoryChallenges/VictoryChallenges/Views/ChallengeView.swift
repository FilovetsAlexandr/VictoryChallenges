//
//  ChallengeView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import SwiftUI

struct ChallengeView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    @State private var showResults = false

    var body: some View {
        ZStack {
            Image("background_challenge")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                if let challenge = viewModel.currentChallenge {
                    Text(challenge.description)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding()

                    Text("Player: \(viewModel.playerNames[viewModel.currentPlayerIndex])")
                        .font(.title)
                        .foregroundColor(.purple)
                        .padding()

                    HStack(spacing: 20) {
                        Button("Success") {
                            viewModel.completeChallenge(success: true)
                            if viewModel.currentChallenge == nil {
                                showResults = true
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Fail") {
                            viewModel.completeChallenge(success: false)
                            if viewModel.currentChallenge == nil {
                                showResults = true
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.selectRandomChallenge()
            }

            NavigationLink(destination: ResultsView(viewModel: viewModel, onRestart: restart), isActive: $showResults) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func restart() {
        viewModel.resetGame()
        showResults = false
    }
}


struct ResultsView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    var onRestart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding()

            ForEach(0..<viewModel.players, id: \.self) { index in
                HStack {
                    Text(viewModel.playerNames[index])
                        .font(.title2)
                        .foregroundColor(.purple)
                    Spacer()
                    Text("\(viewModel.score[index]) points")
                        .font(.title2)
                        .foregroundColor(.purple)
                }
                .padding(.horizontal)
            }

            Button("Back to Main Menu") {
                onRestart()
                DispatchQueue.main.async {
                    popToRoot()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChallengeViewModel()
        viewModel.playerNames = ["Player 1", "Player 2"]
        viewModel.selectedCategory = .physical  // Явно указываем категорию для превью
        viewModel.resetGame()
        
        return ChallengeView(viewModel: viewModel)
    }
}
