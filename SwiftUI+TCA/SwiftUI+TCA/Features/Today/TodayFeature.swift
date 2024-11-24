//
//  TodayFeature.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import ComposableArchitecture
import Combine

struct TodayFeature: ReducerProtocol {
    // MARK: - State
    struct State: Equatable {
        var currentActivity: Activity = .empty()
        var isLoading: Bool = false
        var error: String?
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case onAppear
        case stepsUpdated(Int)
        case motionError(String)
    }
    
    // MARK: - Dependencies
    @Dependency(\.motionService) var motionService
    
    // MARK: - Reducer
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.isLoading = true
            
            guard motionService.isAvailable else {
                state.error = "Step counting is not available on this device"
                state.isLoading = false
                return .none
            }
            
            return .merge(
                motionService.startUpdates()
                    .map(Action.stepsUpdated)
                    .catch { error in
                        Just(Action.motionError(error.localizedDescription))
                    }
                    .eraseToEffect()
            )
            
        case let .stepsUpdated(steps):
            state.currentActivity.steps = steps
            state.isLoading = false
            return .none
            
        case let .motionError(message):
            state.error = message
            state.isLoading = false
            return .none
        }
    }
}
