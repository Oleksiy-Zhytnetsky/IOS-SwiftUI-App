//
//  ContentViewModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    private enum Const {
        static let postsFilename = "posts.json"
        static let settingsFilename = "settings.json"
        
        static let docsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
    }
    
    private var postsFileURL: URL {
        return Const.docsURL.appendingPathComponent(Const.postsFilename)
    }
    
    private var settingsFileURL: URL {
        return Const.docsURL.appendingPathComponent(Const.settingsFilename)
    }
    
    @Published private(set) var posts: [Post] = []
    @Published var authorName: String = ""

    static let shared = ContentViewModel()
    
    func addPost(title: String, text: String, image: Data?) {
        guard isValidAuthor() && isValidContent(title: title, text: text) else {
            return
        }
        
        let newPost = Post(
            id: UUID(),
            authorName: self.authorName,
            title: title,
            text: text,
            image: image
        )
        self.posts.insert(newPost, at: 0)
        self.savePosts()
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
        loadPosts()
    }
    
    // Post persistence
    private func savePosts() {
        if let data = try? JSONEncoder().encode(self.posts) {
            try? data.write(to: self.postsFileURL)
        }
    }
    
    private func loadPosts() {
        guard let data = try? Data(contentsOf: self.postsFileURL) else {
            return
        }
        
        if let savedPosts = try? JSONDecoder().decode([Post].self, from: data) {
            self.posts = savedPosts
        }
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
