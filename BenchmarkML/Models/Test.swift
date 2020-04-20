//
//  Test.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct Test: Identifiable, Decodable, Hashable {
    var id: String
    var name: String
    var description: String
    var model: String
    var trainingTime: Int
    var numberElements: Int
    var elementsPerLabel: Int
    var elementsForAccuracy: Int
    var accuracy: Double
    var trainedModel: String
    var isUpdatable: Bool
    var modelSize: Int
    var classifyTime: Double
    var isAudio: Bool
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as? [String:AnyObject]
        id = snapshot.key
        name = object!["name"] as! String
        description = object!["description"] as! String
        model = object!["model"] as! String
        trainingTime = object!["trainingTime"] as! Int
        numberElements = object!["numberElements"] as! Int
        elementsPerLabel = object!["elementsPerLabel"] as! Int
        elementsForAccuracy = object!["elementsForAccuracy"] as! Int
        accuracy = object!["accuracy"] as! Double
        trainedModel = object!["trainedModel"] as! String
        isUpdatable = object!["isUpdatable"] as! Bool
        modelSize = object!["modelSize"] as! Int
        classifyTime = object!["classifyTime"] as! Double
        isAudio = object!["isAudio"] as! Bool
    }
    
    init(id: String, name: String, description: String, model: String, trainingTime: Int, numberElements: Int, elementsPerLabel: Int, elementsForAccuracy: Int, accuracy: Double, trainedModel: String, isUpdatable: Bool, modelSize: Int, classifyTime: Double, isAudio: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.model = model
        self.trainingTime = trainingTime
        self.numberElements = numberElements
        self.elementsPerLabel = elementsPerLabel
        self.elementsForAccuracy = elementsForAccuracy
        self.accuracy = accuracy
        self.trainedModel = trainedModel
        self.isUpdatable = isUpdatable
        self.modelSize = modelSize
        self.classifyTime = classifyTime
        self.isAudio = isAudio
    }
    
    func toAnyObject() -> [String:AnyObject]{
        var dict: [String:AnyObject] = [:]
        dict["id"] = id as AnyObject
        dict["name"] = name as AnyObject
        dict["description"] = description as AnyObject
        dict["model"] = model as AnyObject
        dict["trainingTime"] = trainingTime as AnyObject
        dict["numberElements"] = numberElements as AnyObject
        dict["elementsPerLabel"] = elementsPerLabel as AnyObject
        dict["elementsForAccuracy"] = elementsForAccuracy as AnyObject
        dict["accuracy"] = accuracy as AnyObject
        dict["trainedModel"] = trainedModel as AnyObject
        dict["isUpdatable"] = isUpdatable as AnyObject
        dict["modelSize"] = modelSize as AnyObject
        dict["classifyTime"] = classifyTime as AnyObject
        dict["isAudio"] = isAudio as AnyObject
        
        return dict
    }
}

