//
//  InputData.swift
//  BenchmarkML
//
//  Created by Admin on 2/26/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct InputData: View {
    var body: some View {
        ZStack(alignment:.bottomLeading){
            Image("Audi")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.black)
//                    .brightness(0.8)
                    .opacity(0.6)
            )
          
            VStack(alignment: .leading){
                Text("Car classifier")
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
                    .padding(.horizontal)
                
                Text("A model trainer to classify cars into Audi or Alfa Romeo labels")
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .padding()
            }
        }
    }
}

struct InputData_Previews: PreviewProvider {
    static var previews: some View {
        InputData()
    }
}
