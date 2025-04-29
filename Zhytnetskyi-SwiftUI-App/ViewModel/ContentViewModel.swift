//
//  ContentViewModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    private enum Const {
        static let settingsFilename = "settings.json"
    }
    
    private var settingsFileURL: URL {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!.appendingPathComponent(Const.settingsFilename)
    }
    
    @Published private(set) var posts: [ExtendedPost] = []
    @Published var authorName: String = ""

    static let shared = ContentViewModel()
    
    func addPost(title: String, text: String, image: Data?) {
        guard isValidAuthor() && isValidContent(title: title, text: text) else {
            return
        }
        
        let postData = Post(
            author_fullname: self.authorName,
            domain: "ios",
            title: title,
            num_comments: 0,
            score: 0,
            selftext: text,
            url: "",
            created: Date.now.timeIntervalSince1970,
            permalink: "",
            image: image
        )
        let newPost = ExtendedPost(data: postData, saved: true)
        self.posts.insert(newPost, at: 0)
        SavedPostsManager.shared.updatePost(newPost)
    }
    
    func isValidAuthor() -> Bool {
        !self.authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isValidContent(title: String, text: String) -> Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private init() {
        loadSettings()
        self.posts = SavedPostsManager.shared.loadSavedPosts()
    }
    
    // Post author name persistence
    func saveSettings() {
        if let data = try? JSONEncoder().encode(SettingsModel(
            authorName: self.authorName
        )) {
            try? data.write(to: self.settingsFileURL)
        }
    }
    
    private func loadSettings() {
        guard let data = try? Data(contentsOf: self.settingsFileURL) else {
            return
        }
        
        if let savedSettings = try? JSONDecoder().decode(SettingsModel.self, from: data) {
            self.authorName = savedSettings.authorName
        }
    }
}
