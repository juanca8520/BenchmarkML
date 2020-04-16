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
                                TestType(model: model)
                                    .frame(width: 300, height: 175)
                                    .overlay(Rectangle().hidden())
                                    .onTapGesture {
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
                                }
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
                                    
                                    FrameworkType(framework: framework)
                                        .frame(width: 300, height: 175)
                                        .onTapGesture {
                                            self.selection["framework"] = framework.name
                                            self.inputData = framework.inputData
                                            withAnimation(.easeInOut(duration: 0.2)){
                                                self.didSelectFramework.toggle()
                                            }
                                            
                                            if self.didSelectInputData {
                                                self.didSelectInputData.toggle()
                                                self.inputData = framework.inputData
                                            }
                                    }
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
                    
                    var size = 0
                    
                    switch self.selectedInputData!.modelName {
                    case "CreateMLCarClassifier":
                        let aStrUrl = Bundle.main.url(forResource: "CreateMLCarClassifierModel", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "CreateMLCatVsDog":
                        let aStrUrl = Bundle.main.url(forResource: "CreateMLCatVsDogModel", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "CreateMLObjectClassifier":
                        let aStrUrl = Bundle.main.url(forResource: "MobileNet", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "TuricreateCatVsDog":
                        let aStrUrl = Bundle.main.url(forResource: "turicreate_cat_vs_dog", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "TuricreateCarClassifier":
                        let aStrUrl = Bundle.main.url(forResource: "turicreate_car_classifier", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "KerasPokemonClassification":
                        let aStrUrl = Bundle.main.url(forResource: "KerasPokedex", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "KerasCarClassifier":
                        let aStrUrl = Bundle.main.url(forResource: "keras_car_classifier", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "CreateMLPokemonClassification":
                        let aStrUrl = Bundle.main.url(forResource: "CreateMLPokedexModel", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "TuricreatePokemonClassification":
                        let aStrUrl = Bundle.main.url(forResource: "turicreate_pokedex", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                        
                    case "UpdatableKerasCarClassifier":
                        let aStrUrl = Bundle.main.url(forResource: "car_classifier_updatable", withExtension: "mlmodelc")
                        size = Int(aStrUrl!.fileSize)
                        print("file size = \(aStrUrl!.fileSize), \(aStrUrl!.fileSizeString)")
                    default:
                        print("holaaaa")
                    }
                    
                    let test = Test(id: "0", name: "\(self.selection["framework"]!) - \(self.selectedInputData!.name)", description: self.selectedInputData!.description, model: self.selectedInputData!.modelName, trainingTime: self.selectedInputData!.timeTotrain, numberElements: self.selectedInputData!.numberOfElements, elementsPerLabel: self.selectedInputData!.elementsPerLabel, elementsForAccuracy: self.selectedInputData!.numberOfElementsToTest, accuracy: self.selectedInputData!.accuracy, trainedModel: self.selectedInputData!.name, isUpdatable: self.selectedInputData!.isUpdatable, modelSize: size, classifyTime: 0.0)
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
        CreateTest(models: .constant([Model]()), selectedInputData: InputData(id: 0, name: "hola", description: "hola", image: "hola", timeTotrain: 1, numberOfElements: 1, numberOfLabels: 1, numberOfElementsToTest: 1, elementsPerLabel: 1, modelName: "", accuracy: 0.1, isUpdatable: true), showingModal: .constant(true))
    }
}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}
