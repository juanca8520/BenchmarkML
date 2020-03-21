//
//  InputData.swift
//  BenchmarkML
//
//  Created by Admin on 2/26/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct InputDataGroup: View {
    var inputData: InputData
    var body: some View {
        ZStack(alignment:.bottomLeading){
            Image(inputData.image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.black)
//                    .brightness(0.8)
                    .opacity(0.6)
            )
          
            VStack(alignment: .leading){
                Text(inputData.name)
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
                    .padding(.horizontal)
                
                Text(inputData.description)
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .padding()
            }
        }
    }
}
