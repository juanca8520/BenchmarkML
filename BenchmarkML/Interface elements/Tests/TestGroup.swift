//
//  TestGroup.swift
//  BenchmarkML
//
//  Created by Admin on 2/24/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct TestGroup: View {
    @State private var createTestModal = false
    @State var models = [Model]()
    @Binding var bindTests: [[Test]]
    var tests: [Test]
    var body: some View {
        HStack{
            if tests.count == 2 {
                NavigationLink(destination: TestDetail(model: tests[0], isUpdatable: tests[0].isUpdatable, isAudio: tests[0].isAudio)){
                    TestRun(test: tests[0])
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: TestDetail(model: tests[1], isUpdatable: tests[1].isUpdatable, isAudio: tests[1].isAudio)){
                    TestRun(test: tests[1])
                }
                .buttonStyle(PlainButtonStyle())
                
            } else {
                NavigationLink(destination: TestDetail(model: tests[0], isUpdatable: tests[0].isUpdatable, isAudio: tests[0].isAudio)){
                    TestRun(test: tests[0])
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.createTestModal.toggle()
                }) {
                    TestRun(test: Test(id: "0", name: "+", description: "Create test", model: "x", trainingTime: 200, numberElements: 500, elementsPerLabel: 25, elementsForAccuracy: 40, accuracy: 0.1, trainedModel: "test", isUpdatable: false, modelSize: 0, classifyTime: 0, isAudio: false, labels: [ModelLabel]()))
                }
                .sheet(isPresented: self.$createTestModal){
                    CreateTest(models: self.$models, showingModal: self.$createTestModal)
                }
            }
        }.onAppear(perform: {
            ModelPersistence.getModels { (list, err) in
                self.models = list
            }
        })
    }
}

struct TestGroup_Previews: PreviewProvider {
    static var previews: some View {
        TestGroup(bindTests: .constant([[Test]]()), tests: [landmarkData[0], landmarkData[1]])
    }
}
