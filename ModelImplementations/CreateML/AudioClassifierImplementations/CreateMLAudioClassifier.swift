//
//  CreateMLAudioClassifier.swift
//  BenchmarkML
//
//  Created by Admin on 4/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import AVKit
import SoundAnalysis

class CreateMLAudioClassifier {
    private let audioEngine = AVAudioEngine()
    private var soundClassifier = SoundClassifier()
    var inputFormat: AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    var resultsObserver = ResultsObserver()
    let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
    
    static var startTime = 0.0
    
    init() {
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
    }
    
    func startAudioEngine() {
        do{
            let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
            try analyzer.add(request, withObserver: resultsObserver)
        }
        catch {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
        
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
                self.analysisQueue.async {
                    CreateMLAudioClassifier.startTime = CFAbsoluteTimeGetCurrent()
                    self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
                }
        }
        
        do{
            try audioEngine.start()
        }
        catch {
            print("Error starting audio engine")
        }
    }

}

class ResultsObserver: NSObject, SNResultsObserving {
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
//            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
            print("\(classification.identifier) -> \(confidence) time: \(CFAbsoluteTimeGetCurrent() - CreateMLAudioClassifier.startTime)")
        }
    }
}
