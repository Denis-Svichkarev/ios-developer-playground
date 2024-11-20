//
//  Counter.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 19/09/24.
//

import Foundation

actor Counter {
    private var value: Int = 0
    
    func increment() {
        value += 1
    }
    
    func getValue() -> Int {
        return value
    }
}

func testActor() {
    let counter = Counter()

    // Parallel tasks to change actor's state
    Task {
        await counter.increment()
        print("Counter after Task 1: \(await counter.getValue())")
    }

    Task {
        await counter.increment()
        print("Counter after Task 2: \(await counter.getValue())")
    }

    Task {
        await counter.increment()
        print("Counter after Task 3: \(await counter.getValue())")
    }

    sleep(1)
}
