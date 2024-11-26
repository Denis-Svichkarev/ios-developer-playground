//
//  RoutesServiceKey.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 25/11/24.
//

import ComposableArchitecture
import Dependencies

private enum RoutesServiceKey: DependencyKey {
    static let liveValue = RoutesService()
    static let previewValue = RoutesService()
}

extension DependencyValues {
    var routesService: RoutesService {
        get { self[RoutesServiceKey.self] }
        set { self[RoutesServiceKey.self] = newValue }
    }
}
