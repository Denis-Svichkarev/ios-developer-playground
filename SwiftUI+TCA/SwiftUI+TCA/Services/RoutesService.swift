//
//  RoutesService.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 25/11/24.
//

import Foundation
import CoreLocation
import Combine

class RoutesService {
    private var currentRoute: Route?
    private var locationManager: CLLocationManager?
    private var locations: [CLLocation] = []
    private var startDate: Date?
    private var steps: Int = 0
    
    func loadRoutes() async throws -> [Route] {
        // TODO: - Change to real data
        return RoutesService.sampleRoutes
    }
    
    // Test data
    static let sampleRoutes: [Route] = [
        Route(
            id: UUID(),
            startDate: Date().addingTimeInterval(-3600),
            endDate: Date(),
            distance: 3500,
            duration: 3600,
            locations: [
                CLLocation(latitude: 55.751244, longitude: 37.618423),
                CLLocation(latitude: 55.753244, longitude: 37.619423),
                CLLocation(latitude: 55.755244, longitude: 37.620423)
            ],
            activityType: .walking,
            steps: 4500
        ),
        Route(
            id: UUID(),
            startDate: Date().addingTimeInterval(-7200),
            endDate: Date().addingTimeInterval(-3600),
            distance: 5000,
            duration: 1800,
            locations: [
                CLLocation(latitude: 55.751244, longitude: 37.618423),
                CLLocation(latitude: 55.757244, longitude: 37.619423)
            ],
            activityType: .running,
            steps: 6000
        )
    ]
}
