//
//  PostModel.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

struct Post: Identifiable, Codable {
    let id: UUID
    let authorName: String
    let title: String
    let text: String
    let image: Data?
}
