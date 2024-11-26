//
//  TodayPreviewData.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation

enum TodayPreviewData {
    static let activities = [
        Activity(
            id: UUID(),
            date: Date(),
            steps: 6543,
            activityType: .walking
        ),
        Activity(
            id: UUID(),
            date: Date(),
            steps: 12345,
            activityType: .running
        ),
        Activity(
            id: UUID(),
            date: Date(),
            steps: 0,
            activityType: .stationary
        )
    ]
    
    static let states = [
        TodayFeature.State(
            currentActivity: activities[0],
            isLoading: false
        ),
        TodayFeature.State(
            currentActivity: activities[1],
            isLoading: false
        ),
        TodayFeature.State(
            currentActivity: .empty(),
            isLoading: true
        )
    ]
}
