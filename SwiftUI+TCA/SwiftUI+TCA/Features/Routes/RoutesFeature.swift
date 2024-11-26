//
//  RouteFeature.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 25/11/24.
//

import ComposableArchitecture

struct RoutesFeature: ReducerProtocol {
    // MARK: - State
    struct State: Equatable {
        var routes: [Route] = []
        var isLoading: Bool = false
        @PresentationState var routeDetails: RouteDetailsFeature.State?
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case onAppear
        case routesLoaded([Route])
        case routeSelected(Route)
        case routeDetails(PresentationAction<RouteDetailsFeature.Action>)
    }
    
    // MARK: - Dependencies
    @Dependency(\.routesService) var routesService
    
    // MARK: - Reducer
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    let routes = try await routesService.loadRoutes()
                    await send(.routesLoaded(routes))
                }
                
            case let .routesLoaded(routes):
                state.routes = routes.sorted(by: { $0.startDate > $1.startDate })
                state.isLoading = false
                return .none
                
            case let .routeSelected(route):
                state.routeDetails = RouteDetailsFeature.State(route: route)
                return .none
                
            case .routeDetails(.presented(.dismiss)):
                state.routeDetails = nil
                return .none
                
            case .routeDetails:
                return .none
            }
        }
        .ifLet(\.$routeDetails, action: /Action.routeDetails) {
            RouteDetailsFeature()
        }
    }
}
