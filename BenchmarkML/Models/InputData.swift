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
    }
    
    init(id: Int, name: String, description: String, image: String, timeTotrain: Int, numberOfElements: Int, numberOfLabels: Int, numberOfElementsToTest: Int, elementsPerLabel: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.timeTotrain = timeTotrain
        self.numberOfElements = numberOfElements
        self.numberOfLabels = numberOfLabels
        self.elementsPerLabel = elementsPerLabel
        self.numberOfElementsToTest = numberOfElementsToTest
    }
}


