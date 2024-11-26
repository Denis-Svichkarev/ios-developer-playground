//
//  SwiftUI_TCAApp.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftUI_TCAApp: App {
    let todayStore = Store(
        initialState: TodayFeature.State(),
        reducer: TodayFeature()
    )
    
    let routesStore = Store(
        initialState: RoutesFeature.State(),
        reducer: RoutesFeature()
    )
     
    var body: some Scene {
        WindowGroup {
            TabView {
                TodayView(store: todayStore)
                    .tabItem {
                        Image(systemName: "figure.walk")
                        Text("Today")
                    }
                
                RoutesView(store: routesStore)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Routes")
                    }
            }
        }
    }
}
