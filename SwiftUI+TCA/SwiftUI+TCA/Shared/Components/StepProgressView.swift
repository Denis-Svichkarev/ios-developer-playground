//
//  StepProgressView.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import SwiftUI

struct StepProgressView: View {
    let steps: Int
    let goal: Int
    let lineWidth: CGFloat
    
    init(
        steps: Int,
        goal: Int = 10000,
        lineWidth: CGFloat = 15
    ) {
        self.steps = steps
        self.goal = goal
        self.lineWidth = lineWidth
    }
    
    private var progress: Double {
        min(Double(steps) / Double(goal), 1.0)
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: lineWidth
                )
            
            // Progress
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .green]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            // Information
            VStack(spacing: 5) {
                Text("\(steps)")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("из \(goal)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("шагов")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
