//
//  TodayPreviewStore.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import ComposableArchitecture

enum TodayPreviewStore {
    static func store(
        initialState: TodayFeature.State = TodayPreviewData.states[0]
    ) -> Store<TodayFeature.State, TodayFeature.Action> {
        Store(
            initialState: initialState,
            reducer: TodayFeature()
        )
    }
}
