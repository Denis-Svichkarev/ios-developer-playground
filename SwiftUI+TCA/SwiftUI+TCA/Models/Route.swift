//
//  Route.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation
import CoreLocation

struct Route: Equatable, Identifiable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let distance: Double
    let duration: TimeInterval
    let locations: [CLLocation]
    let activityType: Activity.ActivityType
    let steps: Int
    
    var formattedDistance: String {
        let kilometers = distance / 1000
        return String(format: "%.2f km", kilometers)
    }
    
    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    var averageSpeed: Double {
        distance / duration
    }
    
    var formattedSpeed: String {
        let kph = averageSpeed * 3.6
        return String(format: "%.1f km/h", kph)
    }
}
