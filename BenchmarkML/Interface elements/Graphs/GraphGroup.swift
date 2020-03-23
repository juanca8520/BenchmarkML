//
//  GraphGroup.swift
//  BenchmarkML
//
//  Created by Admin on 3/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct GraphGroup: View {
    @State var tests = [Test]()
    @State var chunkedTests = [[Test]]()
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(0 ..< chunkedTests.count) {chunkedTest in
                HStack{
                    Text("hola")
                }
            }
        }
    }
}

struct GraphGroup_Previews: PreviewProvider {
    static var previews: some View {
        GraphGroup()
    }
}
