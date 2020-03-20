//
//  CreateTest.swift
//  BenchmarkML
//
//  Created by Admin on 2/23/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import CoreML
import Vision
import ImageIO

struct CreateTest: View {
    @Binding var models: [Model] 
    @State var selectedModel = false
    @State var selectedFramework = false
    @State var selectedInputData = false
    @State var selection = ["model":"", "framework":""]
    @Binding var showingModal: Bool
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: HorizontalAlignment.leading){
                    Text("Select a model")
                        .font(.body)
                        .bold()
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(models) { model in
                                Button(action:{
                                    withAnimation(.easeInOut(duration: 0.2)){
                                        self.selectedModel.toggle()
                                        self.selection["model"] = model.name
                                        if self.selectedFramework {
                                            self.selectedFramework.toggle()
                                        }
                                        if self.selectedInputData {
                                            self.selectedInputData.toggle()
                                        }
                                    }
                                }) {
                                    TestType(model: model)
                                        .frame(width: 300, height: 175)
                                        .overlay(Rectangle().hidden())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    if selectedModel {
                        Text("Select a framework or library")
                            .font(.body)
                            .bold()
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(modelData) { model in
                                    Button(action: {
                                        self.selection["model"] = model.name
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            self.selectedFramework.toggle()
                                        }
                                        
                                        if self.selectedInputData {
                                            self.selectedInputData.toggle()
                                        }
                                        
                                        print(self.selection)
                                    }) {
                                        TestType(model: model)
                                            .frame(width: 300, height: 175)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    if selectedFramework {
                        ConfigureTest(selectedInputData: self.$selectedInputData)
                    }
                    Spacer()
                }
                    .padding(.top)
            }
            .navigationBarTitle("Create test")
            .navigationBarItems(leading:
                Button("Cancel"){
                    self.showingModal = false
                }.foregroundColor(Color.red),
                                trailing:
                Button("Done"){
                    
                }.disabled(!selectedInputData))
            
        }.onAppear(perform: {
            ModelPersistence.getModels { (list, err) in
                self.models = list
                print(self.models)
                print("hola")
            }
        })
    }
}


struct CreateTest_Previews: PreviewProvider {
    static var previews: some View {
        CreateTest(models: .constant(modelData) ,showingModal: .constant(true))
    }
}

