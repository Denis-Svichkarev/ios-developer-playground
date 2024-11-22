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
            Text(post.content)
            Button(action: {
                coordinator.navigate(to: .postDetail(post))
            }) {
                Image(systemName: "camera")
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
        .navigationTitle("News Feed")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    coordinator.logout()
                }) {
                    Image(systemName: "arrow.backward.circle.fill")
                        .foregroundColor(.red)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "camera")
                }
            }
        }
    }
}

#Preview {
    NewsFeedView()
}
