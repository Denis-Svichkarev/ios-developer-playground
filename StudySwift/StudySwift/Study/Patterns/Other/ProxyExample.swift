//
//  ProxyExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

protocol TImage {
    func display()
}

class RealImage: TImage {
    private let filename: String
    
    init(filename: String) {
        self.filename = filename
        loadFromDisk()
    }
    
    func display() {
        print("Displaying \(filename)")
    }
    
    private func loadFromDisk() {
        print("Loading \(filename) from disk")
    }
}

class ProxyImage: TImage {
    private let filename: String
    private var realImage: RealImage?
    
    init(filename: String) {
        self.filename = filename
    }
    
    func display() {
        if realImage == nil {
            realImage = RealImage(filename: filename)
        }
        realImage?.display()
    }
}
