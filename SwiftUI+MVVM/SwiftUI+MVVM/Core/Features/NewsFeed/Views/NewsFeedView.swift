//
//  NewsFeedView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()

    var body: some View {
        List(viewModel.posts) { post in
            Text(post.content)
        }
        .onAppear {
            viewModel.fetchPosts()
        }
        .navigationTitle("News Feed")
        .toolbar {
            Button(action: { /* открыть камеру */ }) {
                Image(systemName: "camera")
            }
        }
    }
}
