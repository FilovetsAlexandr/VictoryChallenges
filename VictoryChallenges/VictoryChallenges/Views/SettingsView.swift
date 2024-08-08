//
//  SettingsView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import MessageUI
import StoreKit
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil

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
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
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
                isShowingMailView = true
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
            .disabled(!MFMailComposeViewController.canSendMail()) // Отключает кнопку, если отправка почты невозможна

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
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $mailResult)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
