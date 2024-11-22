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
            coordinator.start()
        }
    }
}
