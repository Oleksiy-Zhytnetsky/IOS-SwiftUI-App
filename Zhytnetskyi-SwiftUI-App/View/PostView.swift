//
//  PostView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        ZStack {
            Color.secondary
                .opacity(0.2)
                .zIndex(0)
            
            VStack {
                // Post top bar
                HStack(spacing: 4) {
                    Text(self.post.authorName)
                        .lineLimit(1)
                    
                    Text("⋅")
                    Text("10h")
                    Text("⋅")
                    Text("domain")
                    
                    Spacer()
                    
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 20, height: 30)
                }
                .font(Fonts.smallLabel)
                .padding(.top, 5)
                
                // Post title
                HStack {
                    Text(self.post.title)
                        .multilineTextAlignment(.leading)
                        .font(Fonts.smallHeaderLabel)
                        .padding(.top, -5)
                    Spacer()
                }
                
                // Post image or placeholder
                Group {
                    if let data = self.post.image,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    else {
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                Spacer()
                
                // Post bottom bar
                HStack {
                    Image(systemName: "arrowshape.up")
                    Text("100M")
                    Spacer()
                    
                    Image(systemName: "bubble")
                    Text("100M")
                    
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
                .font(Fonts.smallLabel)
                .padding(.bottom, 5)
                
            }
            .padding(.horizontal, 10)
            .zIndex(1)
        }
    }
}
