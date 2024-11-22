//
//  SwiftUI_MVVMApp.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

@main
struct SwiftUI_MVVMApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch coordinator.navigationStack.last {
                case .loading:
                    LoadingView()
                case .auth:
                    AuthView()
                case .newsFeed:
                    NewsFeedView()
                default:
                    Text("Unknown Route")
                }
            }
        }
    }
}
