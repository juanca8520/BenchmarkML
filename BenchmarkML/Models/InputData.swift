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
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        id = object["id"] as! Int
        name = object["name"] as! String
        description = object["description"] as! String
        image = object["image"] as! String
    }
    
    init(id: Int, name: String, description: String, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
}


