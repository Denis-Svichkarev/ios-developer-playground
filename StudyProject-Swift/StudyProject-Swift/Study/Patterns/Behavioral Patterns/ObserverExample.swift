//
//  ObserverExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 14/11/24.
//

import Foundation

protocol Observer: AnyObject {
    func update(subject: Subject)
}

protocol Subject {
    func attach(observer: Observer)
    func detach(observer: Observer)
    func notify()
}

class ConcreteSubject: Subject {
    private var observers = [Observer]()
    var state: Int = 0 {
        didSet {
            notify()
        }
    }
    
    func attach(observer: Observer) {
        observers.append(observer)
    }
    
    func detach(observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notify() {
        for observer in observers {
            observer.update(subject: self)
        }
    }
}

class ConcreteObserver: Observer {
    func update(subject: Subject) {
        if let concreteSubject = subject as? ConcreteSubject {
            print("Observer: Subject's state changed to \(concreteSubject.state)")
        }
    }
}
