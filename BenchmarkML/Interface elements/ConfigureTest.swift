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
    @Binding var selectedInputdata: [InputData]?
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            Text("Select the input data")
                .font(.title)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(selectedInputdata!) { inputData in
                        Button(action: {
                            self.didSelectInputData.toggle()
                        }){
                            InputDataGroup(inputData: inputData).frame(width: 300, height: 175)
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
        ConfigureTest(didSelectInputData: .constant(true), selectedInputdata: .constant([InputData]()))
    }
}
