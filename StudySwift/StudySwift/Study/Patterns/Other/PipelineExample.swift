//
//  PipelineExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

protocol PipelineStage {
    func process(data: String) -> String
}

class TrimStage: PipelineStage {
    func process(data: String) -> String {
        return data.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

class UppercaseStage: PipelineStage {
    func process(data: String) -> String {
        return data.uppercased()
    }
}

class AppendStage: PipelineStage {
    private let suffix: String
    
    init(suffix: String) {
        self.suffix = suffix
    }
    
    func process(data: String) -> String {
        return data + suffix
    }
}

class Pipeline {
    private var stages: [PipelineStage] = []
    
    func addStage(_ stage: PipelineStage) {
        stages.append(stage)
    }
    
    func execute(data: String) -> String {
        var result = data
        for stage in stages {
            result = stage.process(data: result)
        }
        return result
    }
}
