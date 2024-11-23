//
//  SwiftUI_MVVMApp.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

@main
struct SwiftUI_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var userState = DataSourceManager.shared.getUserState()
    
    var body: some View {
        Group {
            if coordinator.isInitializing {
                LoadingView()
            } else {
                NavigationStack(path: $coordinator.path) {
                    if userState.isLoggedIn {
                        NewsFeedView()
                            .environmentObject(coordinator)
                            .environmentObject(userState)
                            .navigationDestination(for: Route.self) { route in
                                if case .postDetail(let post) = route {
                                    PostDetailView(post: post)
                                        .environmentObject(coordinator)
                                }
                            }
                    } else {
                        AuthView()
                            .environmentObject(coordinator)
                            .environmentObject(userState)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
