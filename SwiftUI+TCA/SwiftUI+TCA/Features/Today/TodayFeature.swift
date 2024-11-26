//
//  TodayFeature.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import ComposableArchitecture
import Combine
import Foundation

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
        case onDisappear
        case activityDataUpdated(MotionService.ActivityData)
        case motionError(String)
    }
    
    // MARK: - Dependencies
    @Dependency(\.motionService) var motionService
    
    private enum CancellationID {
        case motionUpdates
    }
    
    // MARK: - Reducer
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.isLoading = true
            
            guard motionService.isAvailable else {
                state.error = "Activity tracking is not available on this device"
                state.isLoading = false
                return .none
            }
            
            return .merge(
                motionService.startUpdates()
                    .receive(on: DispatchQueue.main)
                    .map(Action.activityDataUpdated)
                    .catch { error in
                        Just(Action.motionError(error.localizedDescription))
                    }
                    .eraseToEffect()
                    .cancellable(id: CancellationID.motionUpdates)
            )
            
        case .onDisappear:
            return .cancel(id: CancellationID.motionUpdates)
            
        case let .activityDataUpdated(data):
            state.currentActivity.steps = data.steps
            state.currentActivity.activityType = data.activityType
            state.isLoading = false
            return .none
            
        case let .motionError(message):
            state.error = message
            state.isLoading = false
            return .none
        }
    }
}
