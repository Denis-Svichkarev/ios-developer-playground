//
//  RoutesView.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 25/11/24.
//

import SwiftUI
import ComposableArchitecture

struct RoutesView: View {
    let store: StoreOf<RoutesFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    if viewStore.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                    } else if viewStore.routes.isEmpty {
                        Text("No routes recorded yet")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                    } else {
                        ForEach(viewStore.routes) { route in
                            RouteRow(route: route)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewStore.send(.routeSelected(route))
                                }
                        }
                    }
                }
                .navigationTitle("Routes")
                .task {
                    viewStore.send(.onAppear)
                }
                .sheet(
                    store: self.store.scope(
                        state: \.$routeDetails,
                        action: { .routeDetails($0) }
                    )
                ) { store in
                    NavigationView {
                        RouteDetailsView(store: store)
                    }
                }
            }
        }
    }
}

// MARK: - Route Row
struct RouteRow: View {
    let route: Route
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: route.activityType.iconName)
                    .foregroundColor(.blue)
                
                Text(route.startDate, style: .date)
                    .font(.headline)
                
                Spacer()
                
                Text(route.formattedDistance)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label(route.formattedDuration, systemImage: "clock")
                Spacer()
                Label("\(route.steps) steps", systemImage: "figure.walk")
                Spacer()
                Label(route.formattedSpeed, systemImage: "speedometer")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview
#if DEBUG
struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView(
            store: Store(
                initialState: RoutesFeature.State(
                    routes: RoutesService.sampleRoutes,
                    isLoading: false
                ),
                reducer: RoutesFeature()
            )
        )
    }
}
#endif
