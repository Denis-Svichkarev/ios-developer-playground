//
//  FacadeExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 13/11/24.
//

class CPU {
    func freeze() { print("CPU freeze") }
    func jump(to position: Int) { print("CPU jump to \(position)") }
    func execute() { print("CPU execute") }
}

class Memory {
    func load(address: Int, data: String) { print("Memory load \(data) at address \(address)") }
}

class HardDrive {
    func read(lba: Int, size: Int) -> String {
        print("HardDrive read \(size) bytes from LBA \(lba)")
        return "Data from HDD"
    }
}

class ComputerFacade {
    private let cpu: CPU
    private let memory: Memory
    private let hardDrive: HardDrive
    
    init(cpu: CPU = CPU(), memory: Memory = Memory(), hardDrive: HardDrive = HardDrive()) {
        self.cpu = cpu
        self.memory = memory
        self.hardDrive = hardDrive
    }
    
    func start() {
        cpu.freeze()
        memory.load(address: 0, data: hardDrive.read(lba: 0, size: 1024))
        cpu.jump(to: 0)
        cpu.execute()
    }
}
