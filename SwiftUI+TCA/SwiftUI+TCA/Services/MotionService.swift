//
//  MotionService.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 24/11/24.
//

import CoreMotion
import Foundation
import Combine

class MotionService {
    private let pedometer = CMPedometer()
    private let activityManager = CMMotionActivityManager()
    
    var isAvailable: Bool {
        CMPedometer.isStepCountingAvailable() && CMMotionActivityManager.isActivityAvailable()
    }
    
    struct ActivityData: Equatable {
        let steps: Int
        let activityType: Activity.ActivityType
    }
    
    func startUpdates() -> AnyPublisher<ActivityData, Error> {
        let stepsPublisher = currentStepsPublisher()
        let activityPublisher = currentActivityPublisher()
        
        return Publishers.CombineLatest(stepsPublisher, activityPublisher)
            .map { steps, activity in
                ActivityData(steps: steps, activityType: activity)
            }
            .eraseToAnyPublisher()
    }
    
    private func currentStepsPublisher() -> AnyPublisher<Int, Error> {
        let stepsSubject = PassthroughSubject<Int, Error>()
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        pedometer.startUpdates(from: startOfDay) { data, error in
            if let error = error {
                stepsSubject.send(completion: .failure(error))
                return
            }
            
            if let steps = data?.numberOfSteps.intValue {
                stepsSubject.send(steps)
            } else {
                stepsSubject.send(completion: .failure(MotionError.noData))
            }
        }
        
        return stepsSubject
            .handleEvents(receiveCancel: { [weak self] in
                self?.pedometer.stopUpdates()
            })
            .eraseToAnyPublisher()
    }
    
    private func currentActivityPublisher() -> AnyPublisher<Activity.ActivityType, Error> {
        let activitySubject = PassthroughSubject<Activity.ActivityType, Error>()
        
        activityManager.startActivityUpdates(to: .main) { activity in
            guard let activity = activity else { return }
            
            let activityType: Activity.ActivityType
            
            if activity.running {
                activityType = .running
            } else if activity.walking {
                activityType = .walking
            } else {
                activityType = .stationary
            }
            
            activitySubject.send(activityType)
        }
        
        return activitySubject
            .handleEvents(receiveCancel: { [weak self] in
                self?.activityManager.stopActivityUpdates()
            })
            .eraseToAnyPublisher()
    }
    
    enum MotionError: Error, LocalizedError {
        case notAvailable
        case noData
        
        var errorDescription: String? {
            switch self {
            case .notAvailable:
                return "Activity tracking is not available on this device"
            case .noData:
                return "No activity data available"
            }
        }
    }
}
