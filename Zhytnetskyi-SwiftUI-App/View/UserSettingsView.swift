//
//  UserSettingsView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 22.04.2025.
//

import SwiftUI

struct UserSettingsView: View {
    
    @EnvironmentObject private var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            ResignFRView()
                .zIndex(0)
            
            VStack {
                Text("Settings")
                    .font(Fonts.headerLabel)
                
                HStack {
                    Text("User name")
                        .padding(.horizontal, 10)
                        .padding(.top, 15)
                        .font(Fonts.inputLabel)
                    
                    Spacer()
                }
                
                HStack {
                    TextField(
                        "John Doe",
                        text: self.$viewModel.authorName,
                        onEditingChanged: { isEditing in
                            if (!isEditing) {
                                viewModel.saveSettings()
                            }
                        }
                    )
                    .padding(.leading, 5)
                    .border(Color.primary, width: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .padding(.horizontal, 10)
                    .padding(.top, 0)
                    .font(Fonts.input)
                        
                    Spacer()
                }
                Spacer()
            }
            .padding(.vertical, 10)
            .zIndex(1)
        }
    }
}
