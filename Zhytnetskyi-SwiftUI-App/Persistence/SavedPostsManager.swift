//
//  SavedPostsManager.swift
//  Zhytnetskyi-App
//
//  Created by Oleksiy Zhytnetsky on 01.04.2025.
//

import Foundation

final class SavedPostsManager {
    
    // MARK: - Shared instance
    static let shared = SavedPostsManager()
    
    
    // MARK: - Const
    private enum Const {
        static let filename = "posts.json"
    }
    
    // MARK: - Properties
    private var savedPosts: [ExtendedPost] = []
    
    private var fileUrl: URL {
        let docsUrl = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return docsUrl.appendingPathComponent(Const.filename)
    }
    
    // MARK: - Lifetime
    private init() {
        self.savedPosts = loadSavedPosts()
    }
    
    // MARK: - Public Methods
    func loadSavedPosts() -> [ExtendedPost] {
        guard let data = try? Data(contentsOf: self.fileUrl) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let posts = try? decoder.decode([ExtendedPost].self, from: data) {
            return posts
        }
        return []
    }
    
    func updatePost(_ post: ExtendedPost) {
        if post.saved {
            if !self.savedPosts.contains(where: { areIdentical($0.data, post.data) }) {
                self.savedPosts.append(post)
            }
        }
        else {
            savedPosts.removeAll(where: { areIdentical($0.data, post.data) })
        }
        saveAll()
    }
    
    func isPostSaved(_ post: Post) -> Bool {
        return self.savedPosts.contains(where: { areIdentical($0.data, post) })
    }
        
    func getAllSavedPosts() -> [ExtendedPost] {
        return self.savedPosts.reversed()
    }
    
    // MARK: - Private Methods
    private func saveAll() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(savedPosts) {
            try? data.write(to: self.fileUrl)
        }
    }
    
    private func areIdentical(_ lhs: Post, _ rhs: Post) -> Bool {
        PersistenceUtils.postMatchesInfo(
            post: lhs,
            id: rhs.id,
            permalink: rhs.permalink
        )
    }
}
