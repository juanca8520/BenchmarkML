//
//  ClassificationResults.swift
//  BenchmarkML
//
//  Created by Admin on 2/26/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct ClassificationResults: View {
    @Binding var results: String

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(UIColor.white.withAlphaComponent(0.75)))
            Text(results)
                .foregroundColor(Color.black)
        }
    }
}

struct ClassificationResults_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationResults(results: .constant("hola"))
    }
}
