//
//  InputData.swift
//  BenchmarkML
//
//  Created by Admin on 3/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct InputData: Decodable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var image: String
    var timeTotrain: Int
    var numberOfElements: Int
    var numberOfLabels: Int
    var numberOfElementsToTest: Int
    var elementsPerLabel: Int
    var modelName: String
    var accuracy: Double
    
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        id = object["id"] as! Int
        name = object["name"] as! String
        description = object["description"] as! String
        image = object["image"] as! String
        self.timeTotrain = object["timeToTrain"] as! Int
        self.numberOfElements = object["numberOfElements"] as! Int
        self.numberOfLabels = object["numberOfLabels"] as! Int
        self.elementsPerLabel = object["elementsPerLabel"] as! Int
        self.numberOfElementsToTest = object["numberOfElementsToTest"] as! Int
        self.modelName = object["modelName"] as! String
        self.accuracy = object["accuracy"] as! Double
    }
    
    init(id: Int, name: String, description: String, image: String, timeTotrain: Int, numberOfElements: Int, numberOfLabels: Int, numberOfElementsToTest: Int, elementsPerLabel: Int, modelName: String, accuracy: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.timeTotrain = timeTotrain
        self.numberOfElements = numberOfElements
        self.numberOfLabels = numberOfLabels
        self.elementsPerLabel = elementsPerLabel
        self.numberOfElementsToTest = numberOfElementsToTest
        self.modelName = modelName
        self.accuracy = accuracy
    }
}


