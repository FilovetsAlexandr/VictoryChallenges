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
    @State private var showModal = false
    @State private var showBackToMainButton = false
    
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
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                    Spacer()
                    LottieAnimationViews(name: "chasi")
                        .frame(width: 300, height: 300)
                        .opacity(showBackToMainButton ? 0 : 1)
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
                            checkGameCompletion()
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
                            checkGameCompletion()
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
                
                if showBackToMainButton {
                    Button("Back to main menu") {
                        navigateToRoot()
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(30)
                    .padding()
                }
            }
            .padding()
            .onAppear {
                viewModel.selectRandomChallenge()
            }
            .sheet(isPresented: $showModal) {
                ResultsView(viewModel: viewModel, showModal: $showModal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func checkGameCompletion() {
        if viewModel.currentChallenge == nil {
            showResults = true
            showModal = true
            showBackToMainButton = true
        }
    }

    private func navigateToRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                let newViewModel = ChallengeViewModel()
                let newRootView = ContentView(viewModel: newViewModel)
                let hostingController = UIHostingController(rootView: newRootView)
                window.rootViewController = hostingController
                window.makeKeyAndVisible()
            }
        }
    }
}
