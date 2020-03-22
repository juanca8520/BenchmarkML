//
//  ObtainedResults.swift
//  BenchmarkML
//
//  Created by Admin on 3/22/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Combine

final class ObtainedResults: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    var value: String = "Select an image to start processing"{
        didSet{
            didChange.send()
        }
    }
}
