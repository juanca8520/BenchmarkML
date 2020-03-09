//
//  MyTests.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct MyTests: View {
    let array = landmarkData.chunked(into: 2)
    @State private var createTestModal = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(0 ..< array.count, id: \.self) { row in
                        HStack{
                            TestGroup(tests: self.array[row])
                        }
                        .padding(.horizontal)
                    }
                    HStack{
                        if landmarkData.count % 2 == 0 {
                            Button(action: {
                                self.createTestModal.toggle()
                            }) {
                                TestRun(test: Test(id: 0, name: "+", description: "Create test", model: "x", trainingTime: "200", numberElements: "500", elementsPerLabel: "25", elementsForAccuracy: "40"))
                            }
                            .sheet(isPresented: self.$createTestModal){
                                CreateTest(showingModal: self.$createTestModal)
                            }
                            
                            Button(action: {
                                self.createTestModal.toggle()
                            }) {
                                TestRun(test: Test(id: 0, name: "+", description: "Create test", model: "x", trainingTime: "200", numberElements: "500", elementsPerLabel: "25", elementsForAccuracy: "40"))
                                .hidden()
                            }.sheet(isPresented: self.$createTestModal){
                                CreateTest(showingModal: self.$createTestModal)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("My tests")
        }
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
