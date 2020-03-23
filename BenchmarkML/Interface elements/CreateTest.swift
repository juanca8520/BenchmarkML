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
    @State var didSelectModel = false
    @State var selectedModel: Model?
    @State var inputData: [InputData]?
    @State var selectedInputData: InputData?
    @State var didSelectFramework = false
    @State var didSelectInputData = false
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
                                        self.didSelectModel.toggle()
                                        self.selection["model"] = model.name
                                        self.selectedModel = model
                                        if self.didSelectFramework {
                                            self.didSelectFramework.toggle()
                                        }
                                        if self.didSelectInputData {
                                            self.didSelectInputData.toggle()
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
                    if didSelectModel {
                        Text("Select a framework or library")
                            .font(.body)
                            .bold()
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(selectedModel!.frameworks) { framework in
                                    Button(action: {
                                        self.selection["framework"] = framework.name
                                        self.inputData = framework.inputData
                                        withAnimation(.easeInOut(duration: 0.2)){
                                            self.didSelectFramework.toggle()
                                        }
                                        
                                        if self.didSelectInputData {
                                            self.didSelectInputData.toggle()
                                            self.inputData = framework.inputData
                                        }
                                        
                                        print(self.selection)
                                    }) {
                                        FrameworkType(framework: framework)
                                            .frame(width: 300, height: 175)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    if didSelectFramework {
                        ConfigureTest(didSelectInputData: self.$didSelectInputData, inputData: self.$inputData, selectedInputData: self.$selectedInputData)
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
                    let test = Test(id: 0, name: self.selectedModel!.name, description: self.selectedModel!.description, model: self.selectedInputData!.modelName, trainingTime: self.selectedInputData!.timeTotrain, numberElements: self.selectedInputData!.numberOfElements, elementsPerLabel: self.selectedInputData!.elementsPerLabel, elementsForAccuracy: self.selectedInputData!.numberOfElementsToTest)
                    TestPersistence.createTest(test: test) { (bool, err) in
                        if !bool {
                            fatalError("Algo ocurrió creando el test")
                        } else {
                            self.showingModal.toggle()
                        }
                    }
                }.disabled(!didSelectInputData))
            
        }.onAppear(perform: {
            ModelPersistence.getModels { (list, err) in
                self.models = list
            }
        })
    }
}


struct CreateTest_Previews: PreviewProvider {
    static var previews: some View {
        CreateTest(models: .constant([Model]()), selectedInputData: .init(id: 0, name: "hola", description: "hola", image: "hola", timeTotrain: 1, numberOfElements: 1, numberOfLabels: 1, numberOfElementsToTest: 1, elementsPerLabel: 1, modelName: ""), showingModal: .constant(true))
    }
}

