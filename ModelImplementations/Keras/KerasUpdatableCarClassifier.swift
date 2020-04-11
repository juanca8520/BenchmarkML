//
//  KerasUpdatableCarClassifier.swift
//  BenchmarkML
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Vision
import CoreML

struct KerasUpdatableCarClassifier {
    @Binding var obtainedResults: String
    @Binding var trainSetCount: Int
    var imageConstraint: MLImageConstraint!
    @State var updatableModel : MLModel?
    
    
    init(obtainedResults: Binding<String>, trainSetCount: Binding<Int>) {
        self._obtainedResults = obtainedResults
        self._trainSetCount = trainSetCount
        
        let bundle = Bundle(for: car_classifier_updatable.self)
        let updatableURL = bundle.url(forResource: "car_classifier_updatable", withExtension: "mlmodelc")!
        
        if let model = loadModel(url: updatableURL){
            self.updatableModel = model
            imageConstraint = self.getImageConstraint(model: model)
        }
        else{
            if let modelURL = Bundle.main.url(forResource: "car_classifier_updatable", withExtension: "mlmodelc"){
                if let model = loadModel(url: modelURL){
                    updatableModel = model
                }
            }
        }
        
        if let updatableModel = updatableModel{
            imageConstraint = self.getImageConstraint(model: updatableModel)
        }
        
        
        
    }
    
      /// - Tag: MLModelSetup
      
      func classificationRequest(startTime: CFAbsoluteTime) -> VNCoreMLRequest {
          do {
              let model = try VNCoreMLModel(for: car_classifier_updatable().model)
              
              let request = VNCoreMLRequest(model: model, completionHandler: { request, error in
                  DispatchQueue.main.async {
                      guard let results = request.results else {
                          //Acá tengo que hacer cosas dependiendo de la interfaz que implemente
                          return
                      }
                      
                      let classifications = results as! [VNClassificationObservation]
                      
                      if classifications.isEmpty {
                          //Aca tengo que hacer cosas dependiendo de la interfaz que implemente
                      } else {
                          let topClassifications = classifications.prefix(2)
                          let descriptions = topClassifications.map({ classification in
                              return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                          })
                          // Acá tengo que hacer cosas dependiendo de la interfaz que implemente
                          
                          self.obtainedResults = "Classification:\n" + descriptions.joined(separator: "\n") + "\n\(String(format: "Time: %.2f", (CFAbsoluteTimeGetCurrent() - startTime))) seconds"
                          //                        print(self.obtainedResults)
                      }
                  }
              })
              request.imageCropAndScaleOption = .centerCrop
              return request
          } catch {
              fatalError("Failed to load Vision ML model: \(error)")
          }
      }
      
      /// - Tag: PerformRequests
      func updateClassifications(for image: UIImage) {
          let startTime = CFAbsoluteTimeGetCurrent()
          // Acá tengo que poner algo que me indique que se está clasificando la imagen que pasé al modelo
          self.obtainedResults = "Wait a moment, processing image..."
          
          let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
          guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
          
          DispatchQueue.global(qos: .userInitiated).async {
              let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
              do{
                  try handler.perform([self.classificationRequest(startTime: startTime)])
              } catch {
                  print("Failed to perform classification.\n\(error.localizedDescription)")
              }
          }
      }
      
      /// - Tag: ProcessClassification
      func processClassifications(for request: VNRequest, error: Error?) {
          
      }
    
    //MARK:- Get MLImageConstraints
    func getImageConstraint(model: MLModel) -> MLImageConstraint {
      return model.modelDescription.inputDescriptionsByName["image"]!.imageConstraint!
    }
    
    //MARK:- ModelLoader
    
    private func loadModel(url: URL) -> MLModel? {
      do {
        let config = MLModelConfiguration()
        config.computeUnits = .all
        return try MLModel(contentsOf: url, configuration: config)
      } catch {
        print("Error loading model: \(error)")
        return nil
      }
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    //MARK:- MLArrayBatchProvider
    
    private func batchProvider(imageLabelDictionary: [UIImage:String]) -> MLArrayBatchProvider
    {

        var batchInputs: [MLFeatureProvider] = []
        let imageOptions: [MLFeatureValue.ImageOption: Any] = [
          .cropAndScale: VNImageCropAndScaleOption.scaleFill.rawValue
        ]
        for (image,label) in imageLabelDictionary {
            do{
                let cgi =  image.cgImage!
                let featureValue = try MLFeatureValue(cgImage: cgi, constraint: imageConstraint, options: imageOptions)
              
                if let pixelBuffer = featureValue.imageBufferValue{
                    let x = car_classifier_updatableTrainingInput(image: pixelBuffer, classLabel: label)
                    batchInputs.append(x)
                }
            }
            catch(let error){
                print("error description is \(error.localizedDescription)")
            }
        }
     return MLArrayBatchProvider(array: batchInputs)
    }
    
    func startTraining(imageLabelDictionary: [UIImage : String]) {
        let startTime = CFAbsoluteTimeGetCurrent()
        self.obtainedResults = "Training model with \(self.trainSetCount) images..."
        let modelConfig = MLModelConfiguration()
        modelConfig.computeUnits = .cpuAndGPU
        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
            
            var modelURL = car_classifier_updatable.urlOfModelInThisBundle
            let pathOfFile = documentDirectory.appendingPathComponent("car_classifier_updatable.mlmodelc")
            
            if fileManager.fileExists(atPath: pathOfFile.path){
                modelURL = pathOfFile
            }
                        
            let updateTask = try MLUpdateTask(forModelAt: modelURL, trainingData: batchProvider(imageLabelDictionary: imageLabelDictionary), configuration: modelConfig,
                             progressHandlers: MLUpdateProgressHandlers(forEvents: [.trainingBegin,.epochEnd],
                              progressHandler: { (contextProgress) in
                                print(contextProgress.event)
                                // you can check the progress here, after each epoch
                                
                             }) { (finalContext) in
                                
                                if finalContext.task.error?.localizedDescription == nil{
                                    let fileManager = FileManager.default
                                    do {

                                        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
                                        let fileURL = documentDirectory.appendingPathComponent("car_classifier_updatable.mlmodelc")
                                        try finalContext.model.write(to: fileURL)
                                        
                                        self.updatableModel = self.loadModel(url: fileURL)
                                        
                                        self.obtainedResults = "Done \n Time taken traing model with \(self.trainSetCount) images: \( Double(round(1000*(CFAbsoluteTimeGetCurrent() - startTime))/1000)) seconds"
                                        self.trainSetCount = 0
                                    } catch(let error) {
                                        print("error is \(error.localizedDescription)")
                                    }
                                }
                                
                                
            })
            updateTask.resume()
            
        } catch {
            print("Error while upgrading \(error.localizedDescription)")
        }
    }

}