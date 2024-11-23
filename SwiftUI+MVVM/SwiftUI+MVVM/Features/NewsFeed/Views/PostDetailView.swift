//
//  PostDetailView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct PostDetailView: View {
    @State private var appear = false
    var post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = post.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            let _ = print("🟢 Image loaded successfully")
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .scaleEffect(appear ? 1 : 0.8)
                                .opacity(appear ? 1 : 0)
                        case .failure(let error):
                            let _ = print("🔴 Failed to load image:", error)
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .task {
                        let _ = print("⚪️ Starting image loading from:", url)
                    }
                }
                
                Text(post.content)
                    .opacity(appear ? 1 : 0)
                    .offset(y: appear ? 0 : 20)
            }
            .padding()
        }
        .onAppear {
            let _ = print("🟣 View appeared for post:", post.id)
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                appear = true
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Post details")
    }
}

#Preview {
    let testPost = Post(
        id: UUID(),
        userId: UUID(),
        content: "Test post content",
        imageUrl: "https://picsum.photos/id/2/200/300",
        timestamp: Date()
    )
    
    return NavigationStack {
        Group {
            PostDetailView(post: testPost)
        }
    }
}
