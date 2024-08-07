//
//  UIViewControllerRepresentable.swift
//  VictoryChallenges
//
//  Created by Alexandr Filovets on 7.08.24.
//

import SwiftUI

struct NavigationControllerAccessor: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            if let navigationController = viewController.navigationController {
                context.coordinator.navigationController = navigationController
            }
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        var navigationController: UINavigationController?
    }
}

extension View {
    func popToRootNavigationView() -> some View {
        background(NavigationControllerAccessor())
    }

    func popToRoot() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController as? UINavigationController {
            rootViewController.popToRootViewController(animated: true)
        }
    }
}

