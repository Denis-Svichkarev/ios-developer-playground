//
//  BridgeExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 14/11/24.
//

// MARK - Implementation

protocol Renderer {
    func renderCircle(radius: Double)
}

class VectorRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("Drawing a circle with radius \(radius) using vector renderer")
    }
}

class RasterRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("Drawing a circle with radius \(radius) using raster renderer")
    }
}

// MARK: - Abstraction

protocol TShape {
    func draw()
}

class TCircle: TShape {
    private var renderer: Renderer
    private var radius: Double
    
    init(renderer: Renderer, radius: Double) {
        self.renderer = renderer
        self.radius = radius
    }
    
    func draw() {
        renderer.renderCircle(radius: radius)
    }
}
