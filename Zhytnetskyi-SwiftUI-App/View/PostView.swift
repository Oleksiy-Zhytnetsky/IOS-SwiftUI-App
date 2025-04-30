//
//  PostView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

private typealias PostListConst = PostListViewController.Const

struct PostView: View {
    @State var post: ExtendedPost
    
    var body: some View {
        ZStack {
            Color.secondary
                .opacity(0.2)
                .zIndex(0)
            
            VStack {
                // Post top bar
                HStack(spacing: 4) {
                    Text(self.post.data.author_fullname)
                        .lineLimit(1)
                    
                    Text("⋅")
                    Text(UIKitUtils.formatTimeSincePost(self.post.data.created))
                    Text("⋅")
                    Text(self.post.data.domain)
                    
                    Spacer()
                    
                    Image(systemName: "bookmark\(self.post.saved ? ".fill" : "")")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .onTapGesture {
                            /*
                             * Although the post is just local state,
                             * this assignment is vital for post deletion to work
                             */
                            self.post.saved = false
                            SavedPostsManager.shared.updatePost(self.post)
                            NotificationCenter.default.post(
                                name: NSNotification.Name(PostListConst.postSavedNotificationId),
                                object: nil,
                                userInfo: [
                                    "id": self.post.data.id,
                                    "permalink": self.post.data.permalink,
                                    "saved": false
                                ]
                            )
                        }
                }
                .font(Fonts.smallLabel)
                .padding(.top, 5)
                
                // Post title
                HStack {
                    Text(self.post.data.title)
                        .multilineTextAlignment(.leading)
                        .font(Fonts.smallHeaderLabel)
                        .padding(.top, -5)
                    Spacer()
                }
                
                // Post image or placeholder
                Group {
                    if let data = self.post.data.image,
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
                    Text(UIKitUtils.formatNumCount(self.post.data.score))
                    Spacer()
                    
                    Image(systemName: "bubble")
                    Text(UIKitUtils.formatNumCount(self.post.data.num_comments))
                    
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
