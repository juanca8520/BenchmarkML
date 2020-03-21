//
//  TestType.swift
//  BenchmarkML
//
//  Created by Admin on 2/25/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct TestType: View {
    var model: Model
    var body: some View {
        ZStack(alignment: .top){
            HStack(alignment: .top){
                Image(model.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(model.name)
                        .font(.body)
                        .bold()
                    Text(model.description)
                        .padding()
                }
            }
            .padding()
            TestContainer()
        }
    }
}

struct TestContainer: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(Color(UIColor.black.withAlphaComponent(0.2)))
        
    }
}

struct TestType_Previews: PreviewProvider {
    static var previews: some View {
        TestType(model: Model(id: 1, name: "Core ML", description: "CreateML is a tool created by apple....", image: "coreML", timeTotrain: 1, numberOfElements: 1, numberOfLabels: 1, numberOfElementsToTest: 1, elementsPerLabel: 1, frameworks: [Framework](), inputData: [InputData]()))
    }
}
