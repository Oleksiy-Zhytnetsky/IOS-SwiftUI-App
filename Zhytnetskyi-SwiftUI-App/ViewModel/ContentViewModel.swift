//
//  ContentViewModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published var authorName: String = ""

    static let shared = ContentViewModel()
    
    func addPost(title: String, text: String, image: Data?) -> Bool {
        guard canAddPost(title: title, text: text) else {
            return false
        }
        
        let newPost = Post(
            authorName: self.authorName,
            title: title,
            text: text,
            image: image
        )
        self.posts.insert(newPost, at: 0)
        
        return true
    }
    
    private init() {
        // ...
    }
    
    private func canAddPost(title: String, text: String) -> Bool {
        !self.authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
