//
//  ResultsView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 7.08.24.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    var onRestart: () -> Void

    var body: some View {
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
            Spacer()
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
            NavigationLink(destination: ContentView(viewModel: viewModel)) {
                HStack {
                    Text("Back to main")
                    Image(systemName: "arrow.uturn.backward.circle")
                }
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(30)
            }
        }
        .padding()
        .background(
            Image("background_results")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }
}
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChallengeViewModel()
        viewModel.players = 3
        viewModel.playerNames = ["Alice", "Bob", "Charlie"]
        viewModel.score = [10, 15, 20]

        return ResultsView(viewModel: viewModel) {
            // Restart action
        }
    }
}
