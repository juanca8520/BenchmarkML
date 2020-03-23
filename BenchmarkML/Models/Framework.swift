//
//  Framework.swift
//  BenchmarkML
//
//  Created by Admin on 3/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct Framework: Decodable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var onDeviceTrain: Bool
    var inputData: [InputData]
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        id = object["id"] as! Int
        name = object["name"] as! String
        description = object["description"] as! String
        image = object["image"] as! String
        onDeviceTrain = object["onDevicetrain"] as! Bool
        
        let inputDict = object["inputData"] as! [[String:AnyObject]]
        
        var inputArray = [InputData]()
        for input in inputDict {
            let element = InputData(id: input["id"] as! Int, name: input["name"] as! String, description: input["description"] as! String, image: input["image"] as! String, timeTotrain: input["timeToTrain"] as! Int, numberOfElements: input["numberOfElements"] as! Int, numberOfLabels: input["numberOfLabels"] as! Int, numberOfElementsToTest: input["numberOfElementsToTest"] as! Int, elementsPerLabel: input["elementsPerLabel"] as! Int, modelName: input["modelName"] as! String, accuracy: input["accuracy"] as! Double)
            inputArray.append(element)
        }
        self.inputData = inputArray
    }
    
    init(id: Int, name: String, description: String, image: String, onDeviceTrain: Bool, inputData: [InputData]) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.onDeviceTrain = onDeviceTrain
        self.inputData = inputData
    }
}
