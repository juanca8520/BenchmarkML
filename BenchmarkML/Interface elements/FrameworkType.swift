//
//  FrameworkType.swift
//  BenchmarkML
//
//  Created by Admin on 3/20/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct FrameworkType: View {
    var framework: Framework
    var body: some View {
        ZStack(alignment: .top){
            HStack(alignment: .top){
                Image(framework.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(framework.name)
                        .font(.body)
                        .bold()
                    Text(framework.description)
                        .padding()
                }
            }
            .padding()
            TestContainer()
        }
    }
}

struct FrameworkType_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkType(framework: Framework(id: 1, name: "nombre", description: "descripción", image: "Audi", onDeviceTrain: true))
    }
}
