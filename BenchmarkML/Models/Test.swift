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
    var id: Int
    var name: String
    var description: String
    var model: String
    var trainingTime: Int
    var numberElements: Int
    var elementsPerLabel: Int
    var elementsForAccuracy: Int
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as? [String:AnyObject]
        id = object!["id"] as! Int
        name = object!["name"] as! String
        description = object!["description"] as! String
        model = object!["model"] as! String
        trainingTime = object!["trainingTime"] as! Int
        numberElements = object!["numberElements"] as! Int
        elementsPerLabel = object!["elementsPerLabel"] as! Int
        elementsForAccuracy = object!["elementsForAccuracy"] as! Int
    }
    
    init(id: Int, name: String, description: String, model: String, trainingTime: Int, numberElements: Int, elementsPerLabel: Int, elementsForAccuracy: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.model = model
        self.trainingTime = trainingTime
        self.numberElements = numberElements
        self.elementsPerLabel = elementsPerLabel
        self.elementsForAccuracy = elementsForAccuracy
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
        
        return dict
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

