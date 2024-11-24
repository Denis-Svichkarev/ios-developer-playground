//
//  MotionServiceKey.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import ComposableArchitecture
import Dependencies

private enum MotionServiceKey: DependencyKey {
    static let liveValue = MotionService()
    static let previewValue = MotionService()
}

extension DependencyValues {
    var motionService: MotionService {
        get { self[MotionServiceKey.self] }
        set { self[MotionServiceKey.self] = newValue }
    }
}
