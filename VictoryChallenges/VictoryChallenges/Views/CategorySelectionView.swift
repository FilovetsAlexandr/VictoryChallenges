//
//  CategorySelectionView.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 6.08.24.
//

import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: ChallengeViewModel

    var body: some View {
        ZStack {
            Image("background_categorySelection")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Select a Category")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                LottieAnimationViews(name: "puzzle")
                    .frame(width: 100, height: 100)
                Spacer()
                ForEach(ChallengeCategory.allCases) { category in
                    Button(action: {
                        viewModel.selectedCategory = category
                    }) {
                        Text(category.rawValue)
                            .font(.title2)
                            .foregroundColor(viewModel.selectedCategory == category ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(viewModel.selectedCategory == category ? Color.black : Color.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                }
                Spacer()

                NavigationLink(destination: PlayerSelectionView(viewModel: viewModel)) {
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

//struct CategorySelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySelectionView(viewModel: ChallengeViewModel())
//    }
//}
