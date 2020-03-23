//
//  MyTests.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Combine

struct MyTests: View {
        
    @State var tests = [Test]()
    @State var chunckedTests = [[Test]]()
    @State private var createTestModal = false
    @State var models = [Model]()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(0 ..< chunckedTests.count, id: \.self) { row in
                        HStack{
                            TestGroup(bindTests: self.$chunckedTests, tests: self.chunckedTests[row])
                        }
                        .padding(.horizontal)
                    }
                    HStack{
                        if tests.count % 2 == 0 {
                            Button(action: {
                                self.createTestModal.toggle()

                            }) {
                                TestRun(test: Test(id: 0, name: "+", description: "Create test", model: "x", trainingTime: 200, numberElements: 500, elementsPerLabel: 25, elementsForAccuracy: 40))
                            }
                            .sheet(isPresented: self.$createTestModal){
                                CreateTest(models: self.$models, showingModal: self.$createTestModal)
                            }
                            
                            Button(action: {
                                self.createTestModal.toggle()
                            }) {
                                TestRun(test: Test(id: 0, name: "+", description: "Create test", model: "x", trainingTime: 200, numberElements: 500, elementsPerLabel: 25, elementsForAccuracy: 40))
                                    .hidden()
                            }.sheet(isPresented: self.$createTestModal){
                                CreateTest(models: self.$models, showingModal: self.$createTestModal)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("My tests")
        }
        .onAppear(perform: {
            TestPersistence.getTests { (list, err) in
                //                self.tests = Array(Set(list).subtracting(self.tests))
                print(self.tests.count)
                print(list.count)
                self.tests = list
                self.chunckedTests = list.chunked(into: 2)
                print(self.tests.count)
                print(self.chunckedTests.count)
            }
            
            ModelPersistence.getModels { (list, err) in
                self.models = list
            }
        })
    }
}

struct MyTests_Previews: PreviewProvider {
    static var previews: some View {
        MyTests()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
