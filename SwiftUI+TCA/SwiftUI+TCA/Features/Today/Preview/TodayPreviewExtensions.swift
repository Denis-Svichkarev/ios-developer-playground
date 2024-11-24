//
//  TodayPreviewExtensions.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation
import ComposableArchitecture

extension Activity {
    static var previewWalking: Activity {
        TodayPreviewData.activities[0]
    }
    
    static var previewRunning: Activity {
        TodayPreviewData.activities[1]
    }
    
    static var previewStationary: Activity {
        TodayPreviewData.activities[2]
    }
}

extension TodayFeature.State {
    static var preview: Self {
        TodayPreviewData.states[0]
    }
    
    static var previewRunning: Self {
        TodayPreviewData.states[1]
    }
    
    static var previewLoading: Self {
        TodayPreviewData.states[2]
    }
}

extension Store where State == TodayFeature.State, Action == TodayFeature.Action {
    static var preview: Store<State, Action> {
        TodayPreviewStore.store(initialState: .preview)
    }
    
    static var previewLoading: Store<State, Action> {
        TodayPreviewStore.store(initialState: .previewLoading)
    }
    
    static var previewRunning: Store<State, Action> {
        TodayPreviewStore.store(initialState: .previewRunning)
    }
}
