//
//  PlayerSelectionView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import SwiftUI

struct PlayerSelectionView: View {
    @ObservedObject var viewModel: ChallengeViewModel

    var body: some View {
        ZStack {
            Image("background_playerSelection")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Select \nNumber of Players")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                Spacer()

                LottieAnimationViews(name: "person")
                    .frame(width: 300, height: 300)

                Stepper(value: $viewModel.players, in: 2 ... 6) {
                    Text("\(viewModel.players) Players")
                }
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .cornerRadius(30)
                .padding(.horizontal)
                Spacer()

                NavigationLink(destination: PlayerNamesView(viewModel: viewModel)) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right.circle.fill")
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(30)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .customBackButton()
    }
}

struct PlayerSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSelectionView(viewModel: ChallengeViewModel())
    }
}
