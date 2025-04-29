//
//  RedditApiModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 27.04.2025.
//

import Foundation

struct ExtendedPost : Codable {
    let data: Post
    var saved: Bool
}

struct ApiResponse : Codable {
    let data: PostPaginatedInfo
}

struct PostPaginatedInfo : Codable {
    let after: String?
    let before: String?
    let children: [PostData]
}

struct PostData : Codable {
    let data: Post
}
