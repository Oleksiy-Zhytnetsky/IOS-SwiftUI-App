//
//  ResignFRView.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 23.04.2025.
//

import SwiftUI

struct ResignFRView: View {
    var body: some View {
        Color.gray
            .ignoresSafeArea()
            .opacity(0.01)
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
