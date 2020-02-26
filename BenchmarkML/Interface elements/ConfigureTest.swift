//
//  ConfigureTest.swift
//  BenchmarkML
//
//  Created by Admin on 2/24/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct ConfigureTest: View {
    @Binding var selectedInputData: Bool
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading){
            Text("Select the input data")
                .font(.title)
                .bold()
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button(action: {
                        self.selectedInputData.toggle()
                    }){
                        InputData().frame(width: 300, height: 175)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        self.selectedInputData.toggle()
                    }){
                        InputData().frame(width: 300, height: 175)
                    }
                .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct ConfigureTest_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureTest(selectedInputData: .constant(true))
    }
}
