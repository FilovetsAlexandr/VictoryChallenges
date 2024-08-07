//
//  SettingsView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(30)
            Spacer()

            LottieAnimationViews(name: "settings")
                .frame(width: 300, height: 300)

            Button {
                // Add functionality for rating
            } label: {
                HStack {
                    Text("Rate Us")
                    Image(systemName: "star.circle")
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(30)
                .padding(.horizontal)
            }

            Button {
                // Add functionality for contacting
            } label: {
                HStack {
                    Text("Contact Us")
                    Image(systemName: "person.circle")
                }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(30)
                        .padding(.horizontal)
                
            }
            Spacer()
                
        }
        .background(
            Image("background_settings")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .customBackButton()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
