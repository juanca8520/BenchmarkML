//
//  Model.swift
//  BenchmarkML
//
//  Created by Admin on 2/25/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct Model: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var description: String
    var image: String
    
    init(snapshot: DataSnapshot) {
        let object = snapshot.value as! [String:AnyObject]
        self.id = object["id"] as! Int
        self.name = object["name"] as! String
        self.description = object["description"] as! String
        self.image = object["image"] as! String
    }
    
    init(id: Int, name: String, description: String, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

