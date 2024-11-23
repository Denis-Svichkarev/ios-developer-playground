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
        Group {
            if coordinator.isInitializing {
                LoadingView()
            } else {
                NavigationStack(path: $coordinator.navigationPath) {
                    Group {
                        switch coordinator.currentFlow {
                        case .auth:
                            AuthView()
                                .environmentObject(coordinator)
                        case .main:
                            NewsFeedView()
                                .environmentObject(coordinator)
                        }
                    }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        // Auth routes
                        case .login:
                            AuthView()
                                .environmentObject(coordinator)
                        case .registration:
                            SignUpView()
                                .environmentObject(coordinator)
                        case .forgotPassword:
                            ForgotPasswordView()
                                .environmentObject(coordinator)
                            
                        // Main flow routes
                        case .postDetail(let post):
                            PostDetailView(post: post)
                                .environmentObject(coordinator)
                        case .userProfile(let user):
                            ProfileView(user: user)
                                .environmentObject(coordinator)
                        case .settings:
                            SettingsView()
                                .environmentObject(coordinator)
                        case .createNewPost:
                            CreateNewPostView()
                                .environmentObject(coordinator)
                            
                        // Settings routes
                        case .accountSettings:
                            AccountSettingsView()
                                .environmentObject(coordinator)
                        case .privacySettings:
                            PrivacySettingsView()
                                .environmentObject(coordinator)
                        case .notificationSettings:
                            NotificationSettingsView()
                                .environmentObject(coordinator)
                            
                        // Profile routes
                        case .editProfile:
                            EditProfileView()
                                .environmentObject(coordinator)
                        case .myPosts:
                            MyPostsView()
                                .environmentObject(coordinator)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
