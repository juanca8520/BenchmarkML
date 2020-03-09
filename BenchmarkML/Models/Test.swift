//
//  Test.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct Test: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var description: String
    var model: String
    var trainingTime: String
    var numberElements: String
    var elementsPerLabel: String
    var elementsForAccuracy: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

