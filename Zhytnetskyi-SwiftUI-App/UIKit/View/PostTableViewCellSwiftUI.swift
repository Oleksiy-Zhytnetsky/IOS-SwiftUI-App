//
//  PostTableViewCellSwiftUI.swift
//  Zhytnetskyi-SwiftUI-App
//
//  Created by Oleksiy Zhytnetsky on 30.04.2025.
//

import UIKit
import SwiftUI

private typealias PostListConst = PostListViewController.Const

final class PostTableViewCellSwiftUI: UITableViewCell {
    
    // MARK: - Properties
    private weak var hostingVC: UIViewController?
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
        self.hostingVC?.didMove(toParent: nil)
        self.hostingVC = nil
    }
    
    // MARK: - Public methods
    func configure(for post: ExtendedPost, hostingVC: UIViewController) {
        self.hostingVC = hostingVC
        
        let swiftUIVC: UIViewController = UIHostingController(
            rootView: PostView(post: post)
        )
        let swiftUIView: UIView = swiftUIVC.view
        self.contentView.addSubview(swiftUIView)
        
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUIView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            swiftUIView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            swiftUIView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            swiftUIView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
        
        swiftUIVC.didMove(toParent: self.hostingVC)
    }
}
