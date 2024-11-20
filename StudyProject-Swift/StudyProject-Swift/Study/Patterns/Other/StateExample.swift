//
//  StateExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

protocol TState {
    func handle(context: Context)
}

class Context {
    private var state: TState
    
    init(state: TState) {
        self.state = state
    }
    
    func setState(_ state: TState) {
        self.state = state
    }
    
    func request() {
        state.handle(context: self)
    }
}

class StartState: TState {
    func handle(context: Context) {
        print("Handling Start State")
        context.setState(StopState())
    }
}

class StopState: TState {
    func handle(context: Context) {
        print("Handling Stop State")
        context.setState(StartState())
    }
}
