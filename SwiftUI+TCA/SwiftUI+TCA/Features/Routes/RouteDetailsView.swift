//
//  RouteDetailsView.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import SwiftUI
import ComposableArchitecture
import MapKit
import CoreLocation

struct RouteDetailsView: View {
    let store: StoreOf<RouteDetailsFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 16) {
                    // Map
                    RouteMapView(
                        region: viewStore.binding(
                            get: \.region,
                            send: RouteDetailsFeature.Action.regionChanged
                        ),
                        route: viewStore.route,
                        onAppear: { viewStore.send(.setInitialRegion) }
                    )
                    .frame(height: 300)
                    .cornerRadius(12)
                    
                    // Date and Activity Type
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewStore.route.startDate, style: .date)
                                .font(.headline)
                            Text(viewStore.route.startDate, style: .time)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Label(
                            viewStore.route.activityType.rawValue,
                            systemImage: viewStore.route.activityType.iconName
                        )
                        .font(.headline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Stats Grid
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        StatCard(
                            title: "Distance",
                            value: viewStore.route.formattedDistance,
                            icon: "arrow.left.and.right"
                        )
                        
                        StatCard(
                            title: "Duration",
                            value: viewStore.route.formattedDuration,
                            icon: "clock"
                        )
                        
                        StatCard(
                            title: "Steps",
                            value: "\(viewStore.route.steps)",
                            icon: "figure.walk"
                        )
                        
                        StatCard(
                            title: "Avg Speed",
                            value: viewStore.route.formattedSpeed,
                            icon: "speedometer"
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Route Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        viewStore.send(.dismiss)
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
            
            Text(value)
                .font(.headline)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#if DEBUG
struct RouteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RouteDetailsView(
                store: Store(
                    initialState: RouteDetailsFeature.State(
                        route: RoutesService.sampleRoutes[0]
                    ),
                    reducer: RouteDetailsFeature()
                )
            )
        }
    }
}
#endif
