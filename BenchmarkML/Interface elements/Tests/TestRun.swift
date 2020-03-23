//
//  TestRun.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct TestRun: View {
    var test: Test
    
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color.gray)
//                .foregroundColor(Color(UIColor.black.withAlphaComponent(0.2)))
            VStack(alignment: .leading){
                Text(test.name)
                    .font(.body)
                    .bold()
                Text(test.description)
                    .font(.subheadline)
            }
        .padding()
        }
    }
}

struct TestRun_Previews: PreviewProvider {
    static var previews: some View {
        TestRun(test: landmarkData[1])
            .previewLayout(.fixed(width: 150, height: 125))
    }
}
