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
    var inputData: [InputData]
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.description = object["description"] as! String
        self.image = object["image"] as! String
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
    
    init(id: Int, name: String, description: String, image: String, frameworks: [Framework], inputData: [InputData]) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.frameworks = frameworks
        self.inputData = inputData
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

