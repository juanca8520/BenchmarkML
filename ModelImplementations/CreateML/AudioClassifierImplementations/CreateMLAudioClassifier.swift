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
    var resultsObserver: ResultsObserver?
    let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
    @Binding var results: String
    
    static var startTime = 0.0
    
    init(results: Binding<String>) {
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        self._results = results
        resultsObserver = ResultsObserver(results: $results)
    }
    
    func startAudioEngine() {
        do{
            let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
            try analyzer.add(request, withObserver: resultsObserver!)
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
    @Binding var results: String
    init(results: Binding<String>) {
        self._results = results
    }
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
//            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
            self.results = "\(classification.identifier) -> \(String(format: "Confidence: %.2f",confidence))% time: \(String(format: "Time: %.2f", (CFAbsoluteTimeGetCurrent() - CreateMLAudioClassifier.startTime))) seconds"
        }
    }
}