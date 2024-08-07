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
        NavigationStack {
            ZStack {
                Image("background_challenge")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    if let challenge = viewModel.currentChallenge {
                        Text(challenge.description)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                        Spacer()
                        LottieAnimationViews(name: "chasi")
                            .frame(width: 300, height: 300)
                        Spacer()
                        Text("Turn: \(viewModel.playerNames[viewModel.currentPlayerIndex])")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)

                        HStack(spacing: 20) {
                            Button {
                                viewModel.completeChallenge(success: true)
                                if viewModel.currentChallenge == nil {
                                    showResults = true
                                }
                            } label: {
                                HStack {
                                    Text("Success")
                                    LottieAnimationViews(name: "palec_up")
                                        .frame(width: 30, height: 30)
                                }
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(30)
                            }

                            Button {
                                viewModel.completeChallenge(success: false)
                                if viewModel.currentChallenge == nil {
                                    showResults = true
                                }
                            } label: {
                                HStack {
                                    Text("Fail")
                                    LottieAnimationViews(name: "palec_down")
                                        .frame(width: 30, height: 30)
                                }
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(30)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
                .onAppear {
                    viewModel.selectRandomChallenge()
                }

                .navigationDestination(isPresented: $showResults) {
                    ResultsView(viewModel: viewModel, onRestart: restart)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func restart() {
        viewModel.resetGame()
        showResults = false
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChallengeViewModel()
        viewModel.playerNames = ["Player 1", "Player 2"]
        viewModel.selectedCategory = .physical // Явно указываем категорию для превью
        viewModel.resetGame()

        return ChallengeView(viewModel: viewModel)
    }
}
