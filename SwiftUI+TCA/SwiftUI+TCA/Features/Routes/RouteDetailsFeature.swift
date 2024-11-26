//
//  RouteDetailsFeature.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import ComposableArchitecture
import MapKit
import CoreLocation

struct RouteDetailsFeature: ReducerProtocol {
    // MARK: - State
    struct State: Equatable {
        let route: Route
        var region: MKCoordinateRegion
        var isInitialRegionSet = false
        
        init(route: Route) {
            self.route = route
            self.isInitialRegionSet = false
            
            let locations = route.locations
            let coordinates = locations.map(\.coordinate)
            
            if let first = coordinates.first {
                var minLat = first.latitude
                var maxLat = first.latitude
                var minLon = first.longitude
                var maxLon = first.longitude
                
                for coordinate in coordinates {
                    minLat = min(minLat, coordinate.latitude)
                    maxLat = max(maxLat, coordinate.latitude)
                    minLon = min(minLon, coordinate.longitude)
                    maxLon = max(maxLon, coordinate.longitude)
                }
                
                let latPadding = (maxLat - minLat) * 0.2
                let lonPadding = (maxLon - minLon) * 0.2
                
                let center = CLLocationCoordinate2D(
                    latitude: (minLat + maxLat) / 2,
                    longitude: (minLon + maxLon) / 2
                )
                
                let span = MKCoordinateSpan(
                    latitudeDelta: (maxLat - minLat + latPadding * 2),
                    longitudeDelta: (maxLon - minLon + lonPadding * 2)
                )
                
                self.region = MKCoordinateRegion(center: center, span: span)
                
            } else {
                self.region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
            }
        }
        
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.route == rhs.route &&
            lhs.isInitialRegionSet == rhs.isInitialRegionSet &&
            lhs.region.center.latitude == rhs.region.center.latitude &&
            lhs.region.center.longitude == rhs.region.center.longitude &&
            lhs.region.span.latitudeDelta == rhs.region.span.latitudeDelta &&
            lhs.region.span.longitudeDelta == rhs.region.span.longitudeDelta
        }
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case dismiss
        case regionChanged(MKCoordinateRegion)
        case setInitialRegion
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.dismiss, .dismiss):
                return true
                
            case (.setInitialRegion, .setInitialRegion):
                return true
                
            case let (.regionChanged(lhsRegion), .regionChanged(rhsRegion)):
                return lhsRegion.center.latitude == rhsRegion.center.latitude &&
                       lhsRegion.center.longitude == rhsRegion.center.longitude &&
                       lhsRegion.span.latitudeDelta == rhsRegion.span.latitudeDelta &&
                       lhsRegion.span.longitudeDelta == rhsRegion.span.longitudeDelta
                
            default:
                return false
            }
        }
    }
    
    // MARK: - Reducer
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .dismiss:
            return .none
            
        case let .regionChanged(newRegion):
            if state.isInitialRegionSet {
                state.region = newRegion
            }
            return .none
            
        case .setInitialRegion:
            state.isInitialRegionSet = true
            return .none
        }
    }
}
