//
//  PostListViewControllerSwiftUI.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 30.04.2025.
//

import SwiftUI
import Foundation

struct PostListViewControllerSwiftUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateInitialViewController() as! UINavigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // intentionally empty
    }
}
