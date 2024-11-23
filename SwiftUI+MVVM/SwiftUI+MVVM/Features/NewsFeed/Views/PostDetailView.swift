//
//  PostDetailView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct PostDetailView: View {
    var post: Post
    
    var body: some View {
        Text(post.content)
            .navigationTitle("Post details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PostDetailView(post: Post.init(id: UUID(), userId: UUID(), content: "Test post", timestamp: Date.now))
}
