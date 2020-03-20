//
//  ModelPersistence.swift
//  BenchmarkML
//
//  Created by Admin on 3/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

class ModelPersistence {
    static var ref = Database.database().reference(withPath: "1/models")
    
    static func getModels(completion: @escaping ([Model], Error?) -> Void) {
        var models: [Model] = []
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let model = Model(snapshot: snapshot)
                    models.append(model)
                }
            }
            completion(models, nil)
        })
    }
}
