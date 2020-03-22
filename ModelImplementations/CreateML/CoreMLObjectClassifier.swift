//
//  CoreMLObjectClassifier.swift
//  BenchmarkML
//
//  Created by Admin on 3/9/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//


import SwiftUI
import Vision
import CoreML

class CoreMLObjectClassifier {
    
    static var results = "No results"
    static var startTime = 0.0
    
    /// - Tag: MLModelSetup
    static var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: MobileNet().model)
            
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
                        
                        CoreMLObjectClassifier.results = "Classification:\n" + descriptions.joined(separator: "\n") + "\n\(String(format: "Time: %.2f", (CFAbsoluteTimeGetCurrent() - startTime))) seconds"
                    }
                }
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()

    /// - Tag: PerformRequests
    static func updateClassifications(for image: UIImage) {
        CoreMLObjectClassifier.startTime = CFAbsoluteTimeGetCurrent()
        // Acá tengo que poner algo que me indique que se está clasificando la imagen que pasé al modelo
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do{
                try handler.perform([classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    /// - Tag: ProcessClassification
    func processClassifications(for request: VNRequest, error: Error?) {
        
    }

}

