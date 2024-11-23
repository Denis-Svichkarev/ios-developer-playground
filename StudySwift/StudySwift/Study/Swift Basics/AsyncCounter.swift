//
//  AsyncCounter.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 19/09/24.
//

import Foundation

struct AsyncCounter: AsyncSequence {
    typealias Element = Int
    
    let range: ClosedRange<Int>
    
    struct AsyncIterator: AsyncIteratorProtocol {
        var current: Int
        let range: ClosedRange<Int>
        
        mutating func next() async -> Int? {
            guard current <= range.upperBound else { return nil }
            let nextValue = current
            current += 1
            try? await Task.sleep(nanoseconds: 500_000_000)
            return nextValue
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(current: range.lowerBound, range: range)
    }
}

func testAsyncSequence() {
    Task {
        let asyncCounter = AsyncCounter(range: 1...5)
        
        for await number in asyncCounter {
            print("Received number: \(number)")
        }
    }
}
