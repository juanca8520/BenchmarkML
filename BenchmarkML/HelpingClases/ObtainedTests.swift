//
//  ObtainedTests.swift
//  BenchmarkML
//
//  Created by Admin on 3/22/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Combine

class ObtainedTests: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    var value: [Test] = [Test]() {
        didSet{
            didChange.send()
        }
    }
}
