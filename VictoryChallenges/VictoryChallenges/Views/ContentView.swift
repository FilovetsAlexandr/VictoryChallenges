//
//  ContentView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import Lottie
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChallengeViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Victory Challenges")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                Spacer()

                LottieAnimationViews(name: "joystick")
                    .frame(width: 300, height: 300)
                
                NavigationLink(destination: CategorySelectionView(viewModel: viewModel)) {
                    HStack {
                        Text("Play")
                        Image(systemName: "play.circle")
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(30)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Text("Settings")
                        Image(systemName: "gearshape.circle")
                    }
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(30)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
