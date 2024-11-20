//
//  CommanExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

protocol Command {
    func execute()
}

class Light {
    func turnOn() {
        print("Light is ON")
    }
    
    func turnOff() {
        print("Light is OFF")
    }
}

class TurnOnCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOn()
    }
}

class TurnOffCommand: Command {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOff()
    }
}

class RemoteControl {
    private var command: Command?
    
    func setCommand(_ command: Command) {
        self.command = command
    }
    
    func pressButton() {
        command?.execute()
    }
}
