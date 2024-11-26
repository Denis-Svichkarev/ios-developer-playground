//
//  Activity.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation

struct Activity: Equatable, Identifiable {
    let id: UUID
    let date: Date
    var steps: Int
    var activityType: ActivityType
    
    enum ActivityType: String, Equatable {
        case stationary = "Stationary"
        case walking = "Walking"
        case running = "Running"
        
        var iconName: String {
            switch self {
            case .stationary: return "figure.stand"
            case .walking: return "figure.walk"
            case .running: return "figure.run"
            }
        }
    }
    
    static func empty() -> Activity {
        Activity(
            id: UUID(),
            date: Date(),
            steps: 0,
            activityType: .stationary
        )
    }
}
