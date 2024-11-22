//
//  AppCoordinator.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    func start() -> some View {
        NavigationView {
            AuthView()
                .onAppear {}
        }
    }
}
