//
//  ConfigureTest.swift
//  BenchmarkML
//
//  Created by Admin on 2/24/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct ConfigureTest: View {
    @Binding var didSelectInputData: Bool
    @Binding var inputData: [InputData]?
    @Binding var selectedInputData: InputData?
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            Text("Select the input data")
                .font(.body)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(inputData!) { inputData in
                        Button(action: {
                            self.didSelectInputData.toggle()
                            self.selectedInputData = inputData
                        }){
                            InputDataGroup(inputData: inputData).frame(width: 275, height: 175)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct ConfigureTest_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureTest(didSelectInputData: .constant(true), inputData: .constant([InputData]()), selectedInputData: .constant(InputData(id: 0, name: "hola", description: "hola", image: "hola", timeTotrain: 1, numberOfElements: 1, numberOfLabels: 1, numberOfElementsToTest: 1, elementsPerLabel: 1, modelName: "", accuracy: 0.1)))
    }
}
