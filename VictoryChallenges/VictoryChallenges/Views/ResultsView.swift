//
//  ResultsView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 7.08.24.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    @Binding var showModal: Bool

    var body: some View {
        ZStack{
            Image("background_playerSelection")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                LottieAnimationViews(name: "medal")
                    .frame(width: 300,height: 300)
                ForEach(0 ..< viewModel.players, id: \.self) { index in
                    HStack {
                        Text(viewModel.playerNames[index])
                        Spacer()
                        Text("\(viewModel.score[index]) points")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}
