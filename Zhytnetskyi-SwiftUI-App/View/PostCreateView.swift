//
//  PostCreateView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI
import PhotosUI

struct PostCreateView: View {
    
    @State private var postTitle = ""
    @State private var postText = ""
    @State private var selectedImageItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        VStack {
            
            // Header bar
            HStack {
                Button(
                    action: clearForm,
                    label: {
                        Text("Clear")
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                    }
                )
                .background(Color.red)
                .foregroundStyle(Color.primary)
                .font(Fonts.button)
                .border(Color.primary, width: 2)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                Spacer(minLength: 10)
                
                Text("Create Post")
                    .font(Fonts.secondaryHeaderLabel)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                Button(
                    action: publishForm,
                    label: {
                        Text("Publish")
                            .padding(5)
                    }
                )
                .background(Color.blue)
                .foregroundStyle(Color.primary)
                .font(Fonts.button)
                .border(Color.primary, width: 2)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(.bottom, 5)
            
            // Post title
            Group {
                HStack {
                    Text("Title")
                        .padding(.top, 15)
                        .font(Fonts.inputLabel)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("My first post", text: self.$postTitle)
                        .padding(.leading, 5)
                        .border(Color.primary, width: 1)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .padding(.top, -10)
                        .font(Fonts.input)
                        
                    Spacer()
                }
            }
            .padding(.top, 5)
        
            
            // Post content
            Group {
                HStack {
                    Text("Main text")
                        .padding(.top, 15)
                        .font(Fonts.inputLabel)
                    
                    Spacer()
                }
                
                HStack {
                    TextEditor(text: self.$postText)
                        .padding(.leading, 5)
                        .border(Color.primary, width: 1)
                        .frame(
                            height: UIScreen.main.bounds.height * 0.2
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .padding(.top, -10)
                        .font(Fonts.longInput)
                        
                    Spacer()
                }
            }
            .padding(.top, 5)
            
            // Post image picker
            Group {
                HStack {
                    Text("Image")
                        .padding(.top, 15)
                        .font(Fonts.inputLabel)
                    
                    Spacer()
                }
                
                HStack {
                    PhotosPicker(
                        selection: self.$selectedImageItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text("Select image")
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                    }
                    .background(Color.secondary.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .onChange(of: self.selectedImageItem) { item in
                        Task {
                            if let data = try? await item?.loadTransferable(type: Data.self) {
                                self.selectedImageData = data
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                if let data = self.selectedImageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            height: UIScreen.main.bounds.height * 0.2
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(.top, 5)
                }
            }
            .padding(.top, 5)

            Spacer()
        }
        .padding(.top, 10)
        .padding(.horizontal, 15)
    }
    
    private func clearForm() {
        self.postTitle = ""
        self.postText = ""
        self.selectedImageItem = nil
        self.selectedImageData = nil
    }
    
    private func publishForm() {
        let success = ContentViewModel.shared.addPost(
            title: self.postTitle,
            text: self.postText,
            image: self.selectedImageData
        )
        if (success) {
            clearForm()
        }
    }
}

#Preview {
    PostCreateView()
}
