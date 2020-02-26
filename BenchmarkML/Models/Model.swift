//
//  Model.swift
//  BenchmarkML
//
//  Created by Admin on 2/25/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct Model: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var description: String
    var image: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

