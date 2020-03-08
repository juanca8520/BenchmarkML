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
    
    var tests: [Test]
    var body: some View {
        HStack{
            if tests.count == 2 {
                NavigationLink(destination: TestDetail()){
                    TestRun(test: tests[0])
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: TestDetail()){
                    TestRun(test: tests[1])
                }
                .buttonStyle(PlainButtonStyle())
                
            } else {
                NavigationLink(destination: TestDetail()){
                    TestRun(test: tests[0])
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.createTestModal.toggle()
                }) {
                    TestRun(test: Test(id: 0, name: "+", description: "Create test"))
                }
                .sheet(isPresented: self.$createTestModal){
                    CreateTest(showingModal: self.$createTestModal)
                }
            }
        }
    }
}

struct TestGroup_Previews: PreviewProvider {
    static var previews: some View {
        TestGroup(tests: [landmarkData[0], landmarkData[1]])
    }
}
