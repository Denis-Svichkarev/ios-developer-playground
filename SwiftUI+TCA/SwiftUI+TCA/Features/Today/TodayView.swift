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
            ScrollView {
                VStack(spacing: 20) {
                    if let error = viewStore.error {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    if viewStore.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        StepProgressView(steps: viewStore.currentActivity.steps)
                            .frame(height: 200)
                            .padding()
                        
                        activityTypeCard(viewStore.currentActivity)
                        
                        statsGrid(viewStore.currentActivity)
                    }
                }
                .padding()
            }
            .onAppear { viewStore.send(.onAppear) }
        }
    }
    
    private func activityTypeCard(_ activity: Activity) -> some View {
        VStack {
            Image(systemName: activity.activityType.iconName)
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            Text(activity.activityType.rawValue)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func statsGrid(_ activity: Activity) -> some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 20) {
            statsCard(
                title: "Steps",
                value: "\(activity.steps)",
                icon: "flame.fill",
                color: .orange
            )
            statsCard(
                title: "Calories",
                value: "\(activity.steps / 20)",
                icon: "flame.fill",
                color: .red
            )
        }
    }
    
    private func statsCard(
         title: String,
         value: String,
         icon: String,
         color: Color
     ) -> some View {
         VStack(spacing: 8) {
             Image(systemName: icon)
                 .font(.system(size: 24))
                 .foregroundColor(color)
             
             Text(value)
                 .font(.title2)
                 .bold()
             
             Text(title)
                 .font(.subheadline)
                 .foregroundColor(.secondary)
         }
         .frame(maxWidth: .infinity)
         .padding()
         .background(Color.gray.opacity(0.1))
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
