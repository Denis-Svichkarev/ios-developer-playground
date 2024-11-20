//
//  CompositeExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 14/11/24.
//

protocol Graphic: AnyObject {
    func draw()
}

class Dot: Graphic {
    func draw() {
        print("Drawing a dot")
    }
}

class Circle2: Graphic {
    func draw() {
        print("Drawing a circle")
    }
}

class CompoundGraphic: Graphic {
    private var children = [Graphic]()
    
    func add(child: Graphic) {
        children.append(child)
    }
    
    func remove(child: Graphic) {
        if let index = children.firstIndex(where: { $0 === child }) {
            children.remove(at: index)
        }
    }
    
    func draw() {
        for child in children {
            child.draw()
        }
    }
}
