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
    
    var isAvailable: Bool {
        CMPedometer.isStepCountingAvailable()
    }
    
    // Publish steps update
    func startUpdates() -> AnyPublisher<Int, Error> {
        guard isAvailable else {
            return Fail(error: MotionError.notAvailable).eraseToAnyPublisher()
        }
        
        return Future { promise in
            // Ask data from the first day
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            
            self.pedometer.startUpdates(from: startOfDay) { data, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                if let steps = data?.numberOfSteps.intValue {
                    promise(.success(steps))
                } else {
                    promise(.failure(MotionError.noData))
                }
            }
        }
        .handleEvents(receiveCancel: { [weak self] in
            self?.pedometer.stopUpdates()
        })
        .eraseToAnyPublisher()
    }
    
    enum MotionError: Error {
        case notAvailable
        case noData
    }
}
