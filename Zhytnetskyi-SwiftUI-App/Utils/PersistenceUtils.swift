//
//  PersistenceUtils.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 30.04.2025.
//

import Foundation

final class PersistenceUtils {
    
    static func postMatchesInfo(post: Post, id: UUID, permalink: String) -> Bool {
        if (post.permalink.isEmpty && !permalink.isEmpty) {
            return false
        }
        if (!post.permalink.isEmpty && permalink.isEmpty) {
            return false
        }
        if (!post.permalink.isEmpty && !permalink.isEmpty) {
            return post.permalink == permalink
        }
        return post.id == id
    }
    
}
