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
    var timeTotrain: Int
    var numberOfElements: Int
    var numberOfLabels: Int
    var numberOfElementsToTest: Int
    var elementsPerLabel: Int
    var frameworks: [Framework]
    var inputData: [InputData]
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.description = object["description"] as! String
        self.image = object["image"] as! String
        self.timeTotrain = object["timeToTrain"] as! Int
        self.numberOfElements = object["numberOfElements"] as! Int
        self.numberOfLabels = object["numberOfLabels"] as! Int
        self.elementsPerLabel = object["elementsPerLabel"] as! Int
        self.numberOfElementsToTest = object["numberOfElementsToTest"] as! Int
        
        let dict = object["frameworks"] as! [[String:AnyObject]]
        var frameworkArray = [Framework]()
        for framework in dict {
            let element = Framework(id: framework["id"] as! Int, name: framework["name"] as! String, description: framework["description"] as! String, image: framework["image"] as! String, onDeviceTrain: framework["onDeviceTrain"] as! Bool)
            frameworkArray.append(element)
        }
        self.frameworks = frameworkArray
        
        let inputDict = object["inputData"] as! [[String:AnyObject]]
        
        var inputArray = [InputData]()
        for input in inputDict {
            let element = InputData(id: input["id"] as! Int, name: input["name"] as! String, description: input["description"] as! String, image: input["image"] as! String)
            inputArray.append(element)
        }
        self.inputData = inputArray
    }
    
    init(id: Int, name: String, description: String, image: String, timeTotrain: Int, numberOfElements: Int, numberOfLabels: Int, numberOfElementsToTest: Int, elementsPerLabel: Int, frameworks: [Framework], inputData: [InputData]) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.timeTotrain = timeTotrain
        self.numberOfElements = numberOfElements
        self.numberOfLabels = numberOfLabels
        self.elementsPerLabel = elementsPerLabel
        self.numberOfElementsToTest = numberOfElementsToTest
        self.frameworks = frameworks
        self.inputData = inputData
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

