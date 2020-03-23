//
//  ContentView.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @EnvironmentObject var tests: Tests
    
    var body: some View {
        TabView{
            MyTests()
                .tabItem{
                    Image(systemName: "tray.2")
                    Text("Tests")
            }
            
            ModelComparison()
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Comparison")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
