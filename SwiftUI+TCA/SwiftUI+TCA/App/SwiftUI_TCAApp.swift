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
    let store = Store(
         initialState: TodayFeature.State(),
         reducer: TodayFeature()
     )
     
     var body: some Scene {
         WindowGroup {
             TabView {
                 TodayView(store: store)
                     .tabItem {
                         Image(systemName: "figure.walk")
                         Text("Today")
                     }
             }
         }
     }
}
