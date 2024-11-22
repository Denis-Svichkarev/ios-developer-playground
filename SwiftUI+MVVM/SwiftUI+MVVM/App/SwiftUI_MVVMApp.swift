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

    var body: some View {
        NavigationView {
            switch coordinator.navigationStack.last {
            case .loading:
                LoadingView()
            case .auth:
                AuthView()
                    .environmentObject(coordinator)
            case .newsFeed:
                NewsFeedView()
                    .environmentObject(coordinator)
            case .postDetail(_):
                PostDetailView()
                    .environmentObject(coordinator)
            default:
                Text("Unknown Route")
            }
        }
    }
}

#Preview {
    ContentView()
}
