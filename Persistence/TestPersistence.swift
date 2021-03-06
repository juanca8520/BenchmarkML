//
//  TestPersistence.swift
//  BenchmarkML
//
//  Created by Admin on 3/19/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

class TestPersistence {
    static var ref = Database.database().reference(withPath: "0/tests")
        
    static func getTests(completion: @escaping ([Test], Error?) -> Void) {
        var tests = [Test]()
        ref.observe(.value, with: { snapshot in
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let test = Test(snapshot: snapshot)
                    tests.append(test)
                }
            }
            completion(tests, nil)
            tests = []
        })
    }
    
    static func createTest(test: Test, completion: @escaping (Bool, Error?) -> Void){
        let testRef = self.ref.childByAutoId()
        testRef.setValue(test.toAnyObject())
        completion(true, nil)
    }
    
    static func setTest(test: Test, completion: @escaping (Bool, Error?) -> Void) {
        
        var labels = [[String:AnyObject]]()
        for label in test.labels {
            labels.append(label.toAnyObject())
        }
        self.ref.child(test.id).setValue(test.toAnyObject())
    }
    
    static func deleteTest(test: Test, completion: @escaping (Bool, Error?) -> Void) {
        let testRef = Database.database().reference(withPath: "0/tests/" + test.id)
        testRef.removeValue()
        completion(true, nil)
    }
}
