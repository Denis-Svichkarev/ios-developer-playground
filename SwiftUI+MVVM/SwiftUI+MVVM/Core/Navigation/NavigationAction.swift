//
//  NavigationAction.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 23/11/24.
//

enum NavigationAction {
    // Auth actions
    case showRegistration
    case showForgotPassword
    case loginSuccess
    case logout
    
    // Main flow actions
    case showPostDetail(Post)
    case showProfile(User)
    case showSettings
    case createNewPost
    
    // Settings actions
    case showAccountSettings
    case showPrivacySettings
    case showNotificationSettings
    
    // Profile actions
    case showEditProfile
    case showMyPosts
    
    // Common actions
    case back
    case backToRoot
}
