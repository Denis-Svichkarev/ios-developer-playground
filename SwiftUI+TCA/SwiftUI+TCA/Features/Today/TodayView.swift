//
//  TodayView.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import SwiftUI
import ComposableArchitecture

struct TodayView: View {
    let store: Store<TodayFeature.State, TodayFeature.Action>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 20) {
                if let error = viewStore.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if viewStore.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    activityTypeCard(viewStore.currentActivity)
                    stepsCard(viewStore.currentActivity.steps)
                }
            }
            .padding()
            .onAppear { viewStore.send(.onAppear) }
        }
    }
    
    private func activityTypeCard(_ activity: Activity) -> some View {
        VStack {
            Image(systemName: activity.activityType.iconName)
                .font(.system(size: 50))
            
            Text(activity.activityType.rawValue)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func stepsCard(_ steps: Int) -> some View {
        VStack {
            Text("Steps Today")
                .font(.headline)
            
            Text("\(steps)")
                .font(.system(size: 40, weight: .bold))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

#if DEBUG
struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodayView(store: .preview)
                .previewDisplayName("Walking")
            
            TodayView(store: .previewRunning)
                .previewDisplayName("Running")
            
            TodayView(store: .previewLoading)
                .previewDisplayName("Loading")
        }
    }
}
#endif
