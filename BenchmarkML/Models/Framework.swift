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
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        id = object["id"] as! Int
        name = object["name"] as! String
        description = object["description"] as! String
        image = object["image"] as! String
        onDeviceTrain = object["onDevicetrain"] as! Bool
    }
    
    init(id: Int, name: String, description: String, image: String, onDeviceTrain: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.onDeviceTrain = onDeviceTrain
    }
}
