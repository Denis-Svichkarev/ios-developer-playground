//
//  NewsFeedView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct NewsFeedView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var userState: UserState
    @StateObject private var viewModel = NewsFeedViewModel()

    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                Text(post.content)
                Button("View Details") {
                    coordinator.path.append(.postDetail(post))
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
                    coordinator.logout()
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
