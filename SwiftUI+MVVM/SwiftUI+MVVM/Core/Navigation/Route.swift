//
//  Route.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

enum Route: Hashable {
    // Auth flow routes
    case registration
    case forgotPassword
    
    // Main flow routes
    case postDetail(Post)
    case userProfile(User)
    case settings
    case createNewPost
    
    // Settings flow routes
    case accountSettings
    case privacySettings
    case notificationSettings
    
    // Profile flow routes
    case editProfile
    case myPosts
}
