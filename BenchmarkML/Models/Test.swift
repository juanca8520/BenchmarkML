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
    var trainingTime: String
    var numberElements: String
    var elementsPerLabel: String
    var elementsForAccuracy: String
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as? [String:AnyObject]
        id = object!["id"] as! Int
        name = object!["name"] as! String
        description = object!["description"] as! String
        model = object!["model"] as! String
        trainingTime = object!["trainingTime"] as! String
        numberElements = object!["numberElements"] as! String
        elementsPerLabel = object!["elementsPerLabel"] as! String
        elementsForAccuracy = object!["elementsForAccuracy"] as! String
    }
    
    init(id: Int, name: String, description: String, model: String, trainingTime: String, numberElements: String, elementsPerLabel: String, elementsForAccuracy: String) {
        self.id = id
        self.name = name
        self.description = description
        self.model = model
        self.trainingTime = trainingTime
        self.numberElements = numberElements
        self.elementsPerLabel = elementsPerLabel
        self.elementsForAccuracy = elementsForAccuracy
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

