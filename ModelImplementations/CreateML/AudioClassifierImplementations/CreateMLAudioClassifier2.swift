//
//  CreateMLAudioClassifier2.swift
//  BenchmarkML
//
//  Created by Admin on 4/28/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import AVKit
import SoundAnalysis

struct CreateMLAudioClassifier2: ModelProtocol {
    private let audioEngine = AVAudioEngine()
       private var soundClassifier = SoundClassifier2()
       
       var inputFormat: AVAudioFormat!
       var analyzer: SNAudioStreamAnalyzer!
       var resultsObserver: ResultsObserver?
       let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
       
       @Binding var results: String
       @Binding var test: Test
       
       static var startTime = 0.0
       static var averageClassifyingTime = 0.0
       
       init(results: Binding<String>, test: Binding<Test>) {
           inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
           analyzer = SNAudioStreamAnalyzer(format: inputFormat)
           self._results = results
           self._test = test
           resultsObserver = ResultsObserver(results: $results, test: $test)
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
       
       func stopAudioEngine() {
           audioEngine.stop()
           self.test.classifyTime = CreateMLAudioClassifier.averageClassifyingTime
           
           TestPersistence.setTest(test: self.test) { (success, err) in
               if !success {
                   print(err as Any)
               }
           }
       }

}

