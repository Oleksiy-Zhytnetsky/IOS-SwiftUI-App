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
            
            self.postCreateSubview
                .tabItem {
                    VStack {
                        Image(systemName: "plus")
                        Text("New post")
                    }
                }
            
            self.userSettingsSubview
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
        ScrollView {
            LazyVStack {
                ForEach(
                    Array(self.viewModel.posts.enumerated()),
                    id: \.offset
                ) { _, post in
                    PostView(post: post)
                        .frame(
                            height: 300
                        )
                        .padding(.bottom, 5)
                }
            }
        }
    }
    
    @ViewBuilder
    private var postCreateSubview: some View {
        PostCreateView()
    }
    
    @ViewBuilder
    private var userSettingsSubview: some View {
        UserSettingsView()
    }
}

#Preview {
    ContentView()
}
