//
//  ModelImplementationProtocol.swift
//  BenchmarkML
//
//  Created by Admin on 5/24/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

protocol ModelImplementationProtocol {
    func resetModel()
    func startTraining(imageLabelDictionary: [UIImage : String])
}
