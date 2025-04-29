//
//  PostModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

struct Post: Identifiable, Codable {
    let id = UUID()
    let author_fullname: String
    let domain: String
    let title: String
    let num_comments: Int
    let score: Int
    let selftext: String
    let url: String // raw img url
    let created: TimeInterval // unix timestamp
    let permalink: String
    let image: Data?
    
    var cleanedUrl: String {
        return url.replacingOccurrences(of: "&amp;", with: "&")
    }
    
    var postUrl: String {
        return "https://www.reddit.com" + permalink
    }
}
