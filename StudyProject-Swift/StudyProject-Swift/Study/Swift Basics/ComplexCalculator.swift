//
//  ComplexCalculator.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 22/09/24.
//

import Foundation

class ComplexCalculator {
    lazy var result: Int = {
        print("Performing complex calculation...")
        var sum = 0
        for i in 1...1_000_000 {
            sum += i
        }
        return sum
    }()
}
