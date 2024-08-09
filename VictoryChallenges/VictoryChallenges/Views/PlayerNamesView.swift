//
//  PlayerNamesView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import SwiftUI

struct PlayerNamesView: View {
    @ObservedObject var viewModel: ChallengeViewModel

    var body: some View {
        ZStack {
            Image("background_playerNames")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Enter Player Names")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)

                LottieAnimationViews(name: "person")
                    .frame(width: 300, height: 300)

                Spacer()

                ForEach(0 ..< viewModel.players, id: \.self) { index in
                    TextField("Player \(index + 1)", text: Binding(
                        get: { viewModel.playerNames.indices.contains(index) ? viewModel.playerNames[index] : "" },
                        set: {
                            let truncatedText = String($0.prefix(10)) 
                            viewModel.playerNames[index] = truncatedText
                        }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .cornerRadius(30)
                    .padding(.horizontal)
                }

                Spacer()

                NavigationLink(destination: ChallengeView(viewModel: viewModel)) {
                    HStack {
                        Text("Start!")
                        Image(systemName: "flag.2.crossed.circle")
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(allNamesValid ? Color.black : Color.black.opacity(0.5))
                    .cornerRadius(30)
                }
                .disabled(!allNamesValid)
                .padding(.horizontal)
            }
            .padding()
            .onAppear {
                if viewModel.playerNames.count < viewModel.players {
                    viewModel.playerNames = Array(repeating: "", count: viewModel.players)
                }
            }
        }
        .customBackButton()
        .hideKeyboardOnTap()
    }

    private var allNamesValid: Bool {
        viewModel.playerNames.allSatisfy { !$0.isEmpty && $0.count <= 10 }
    }
}

struct PlayerNamesView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerNamesView(viewModel: ChallengeViewModel())
    }
}
