//
//  NewsFeedView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct NewsFeedView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = NewsFeedViewModel()

    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                Text(post.content)
                Button("View Details") {
                    coordinator.handle(.showPostDetail(post))
                }
            }
        }
        .onAppear() {
            viewModel.fetchPosts()
        }
        .navigationTitle("News Feed")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    coordinator.handle(.logout)
                }) {
                    Image(systemName: "arrow.backward.circle.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    NewsFeedView()
}
