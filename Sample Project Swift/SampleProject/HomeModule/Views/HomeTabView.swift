//
//  HomeTabView.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import SwiftUI

struct TabItem {
    var view: AnyView
    var tabTitle: String
    var tabImage: String
}

struct HomeTabView: View {
    @State private var selectedTab = 0
    var userViewModel: UserViewModel
    
    var tabItems: [TabItem] {
        [
            TabItem(view: AnyView(NewsView()), tabTitle: "News", tabImage: "news_icon"),
            TabItem(view: AnyView(FriendsView()), tabTitle: "Friends", tabImage: "friends_icon"),
            TabItem(view: AnyView(ProfileView()), tabTitle: "Profile", tabImage: "profile_icon"),
            TabItem(view: AnyView(SettingsView(userViewModel: userViewModel)), tabTitle: "Settings", tabImage: "settings_icon")
        ]
    }
        
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<tabItems.count) { index in
                tabItems[index].view
                    .tabItem {
                        Image(systemName: tabItems[index].tabImage)
                            Text(tabItems[index].tabTitle)
                        }
                    .tag(index)
            }
        }
    }
}

struct NewsView: View {
    var body: some View {
        Text("News View")
    }
}

struct FriendsView: View {
    var body: some View {
        Text("Friends View")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
    }
}

struct SettingsView: View {
    var userViewModel: UserViewModel
    
    var body: some View {
        Text("Settings View")
//        Button("Logout") {
//            userViewModel.clearUser()
//        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(userViewModel: UserViewModel(userService: MockUserService()))
    }
}
