//
//  ContentView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 20.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel.shared
    
    var body: some View {
        TabView {
            self.postListSubview
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Feed")
                    }
                }
            
            PostCreateView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus")
                        Text("New post")
                    }
                }
            
            UserSettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                }
        }
        .environmentObject(viewModel)
    }
    
    @ViewBuilder
    private var postListSubview: some View {
        
        Group {
            if (self.viewModel.posts.isEmpty) {
                VStack {
                    Text("No posts here yet")
                        .font(Fonts.headerLabel)
                        .padding(.bottom, 5)
                    
                    Text("Create one by navigating to the \"New post\" tab!")
                        .font(Fonts.secondaryLabel)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
            }
            else {
                ScrollView {
                    LazyVStack {
                        ForEach(self.viewModel.posts) { post in
                            PostView(post: post)
                                .frame(
                                    height: 300
                                )
                                .padding(.bottom, 5)
                                .padding(.horizontal, 5)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
