//
//  Model.swift
//  BenchmarkML
//
//  Created by Admin on 2/25/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct Model: Identifiable {
    
    var id: Int
    var name: String
    var description: String
    var image: String
    var frameworks: [Framework]
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.description = object["description"] as! String
        self.image = object["image"] as! String
//        self.timeTotrain = object["timeToTrain"] as! Int
//        self.numberOfElements = object["numberOfElements"] as! Int
//        self.numberOfLabels = object["numberOfLabels"] as! Int
//        self.elementsPerLabel = object["elementsPerLabel"] as! Int
//        self.numberOfElementsToTest = object["numberOfElementsToTest"] as! Int
        
        let dict = object["frameworks"] as! [[String:AnyObject]]
        var frameworkArray = [Framework]()
        for framework in dict {
            let inputDataDict = framework["inputData"] as! [[String:AnyObject]]
            var inputDataArray = [InputData]()
            for inputData in inputDataDict {
                let inputDataElement = InputData(id: inputData["id"] as! Int, name: inputData["name"] as! String, description: inputData["description"] as! String, image: inputData["image"] as! String, timeTotrain: inputData["timeToTrain"] as! Int, numberOfElements: inputData["numberOfElements"] as! Int, numberOfLabels: inputData["numberOfLabels"] as! Int, numberOfElementsToTest: inputData["numberOfElementsToTest"] as! Int, elementsPerLabel: inputData["elementsPerLabel"] as! Int, modelName: inputData["modelName"] as! String, accuracy: inputData["accuracy"] as! Double)
                inputDataArray.append(inputDataElement)
            }
            
            let element = Framework(id: framework["id"] as! Int, name: framework["name"] as! String, description: framework["description"] as! String, image: framework["image"] as! String, onDeviceTrain: framework["onDeviceTrain"] as! Bool, inputData: inputDataArray)
            frameworkArray.append(element)
        }
        self.frameworks = frameworkArray
        
//        let inputDict = object["inputData"] as! [[String:AnyObject]]
//
//        var inputArray = [InputData]()
//        for input in inputDict {
//            let element = InputData(id: input["id"] as! Int, name: input["name"] as! String, description: input["description"] as! String, image: input["image"] as! String)
//            inputArray.append(element)
//        }
//        self.inputData = inputArray
    }
    
    init(id: Int, name: String, description: String, image: String, frameworks: [Framework]) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.frameworks = frameworks
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

