//
//  ModelLabel.swift
//  BenchmarkML
//
//  Created by Admin on 5/11/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct ModelLabel: Identifiable, Decodable {
    
    var id: Int
    var name: String
    var numberOfElements: Int
    
    init(snapshot: DataSnapshot){
        let object = snapshot.value as! [String:AnyObject]
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.numberOfElements = object["numberOfelements"] as! Int
    }
    
    init(id: Int, name: String, numberOfElements: Int){
        self.id = id
        self.name = name
        self.numberOfElements = numberOfElements
    }
    
    func toAnyObject() -> [String:AnyObject]{
        var dict: [String:AnyObject] = [:]
        dict["id"] = id as AnyObject
        dict["name"] = name as AnyObject
        dict["numberOfElements"] = numberOfElements as AnyObject
        
        return dict
    }
}

