//
//  FrameworkPersistence.swift
//  BenchmarkML
//
//  Created by Admin on 3/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

class FrameworkPersistence {
    static var ref = Database.database().reference(withPath: "2/frameworks")
    
    static func getFrameworks(completion: @escaping ([Framework], Error?) -> Void) {
        var frameworks = [Framework]()
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let framework = Framework(snapshot: snapshot)
                    frameworks.append(framework)
                }
            }
            completion(frameworks, nil)
        })
    }
}
