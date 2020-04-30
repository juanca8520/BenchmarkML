//
//  modelComparison.swift
//  BenchmarkML
//
//  Created by Admin on 3/22/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct ModelComparison: View {
    
    @State var trainingDict = [String:[(key: String, val: Int)]]()
    @State var accuracyDict = [String:[(key: String, val: Double)]]()
    @State var timeDict = [String:[(key: String, val: Double)]]()
    @State var fileSizeDict = [String:[(key: String, val: Int)]]()
    
    @State var chartDataTimeToTrain = [(key: String, val: Int)]()
    @State var chartDataAccuracy = [(key: String, val: Double)]()
    @State var chartDataTimeClassification = [(key: String, val: Double)]()
    @State var chartFileSizeData = [(key: String, val: Int)]()
    
    @State var tests = [Test]()
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["Cats vs dogs"] != nil {
                                Text("Cat vs dog classification").padding(.horizontal)

                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["Cats vs dogs"] ?? chartDataTimeToTrain), title: "Training time", legend: "Time in seconds taken to train the model ", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["Cats vs dogs"] ?? chartDataAccuracy), title: "Model's accuracy", legend: "Accuracy obtained after training the model", form: ChartForm.medium, valueSpecifier: "%.2f")
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["Cats vs dogs"] ?? chartDataTimeClassification), title: "Time to classify an image", form: ChartForm.medium)

                                    BarChartView(data: ChartData(values: fileSizeDict["Cats vs dogs"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)

                                }.padding(.bottom)
                                Divider()
                            }
                        }
                    }.padding()

                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["Car classifier"] != nil {
                                Text("Car classifier").padding(.horizontal)
                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["Car classifier"] ?? chartDataTimeToTrain), title: "Time to train in seconds", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["Car classifier"] ?? chartDataAccuracy), title: "Accuracy per framework", form: ChartForm.medium)
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["Car classifier"] ?? chartDataTimeClassification), title: "Time to classify an image", form: ChartForm.medium)

                                    BarChartView(data: ChartData(values: fileSizeDict["Car classifier"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)
                                }
                                Divider()
                            }
                        }
                    }.padding()

                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["Object classification"] != nil {
                                Text("Object classifier").padding(.horizontal)
                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["Object classifier"] ?? chartDataTimeToTrain), title: "Time to train in seconds", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["Object classifier"] ?? chartDataAccuracy), title: "Accuracy per framework", form: ChartForm.medium)
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["Object classifier"] ?? chartDataTimeClassification), title: "Time to classify an image", form: ChartForm.medium)

                                    BarChartView(data: ChartData(values: fileSizeDict["Object classifier"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)
                                }
                                Divider()
                            }
                        }
                    }.padding()

                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["Pokedex"] != nil {
                                Text("Pokedex").padding(.horizontal)
                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["Pokedex"] ?? chartDataTimeToTrain), title: "Time to train in seconds", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["Pokedex"] ?? chartDataAccuracy), title: "Accuracy per framework", form: ChartForm.medium)
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["Pokedex"] ?? chartDataTimeClassification), title: "Time to classify an image", form: ChartForm.medium)

                                    BarChartView(data: ChartData(values: fileSizeDict["Pokedex"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)
                                }
                                Divider()
                            }
                        }
                        Divider()
                    }.padding()

                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["General audio classifier"] != nil {
                                Text("General audio classifier").padding(.horizontal)
                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["General audio classifier"] ?? chartDataTimeToTrain), title: "Time to train in seconds", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["General audio classifier"] ?? chartDataAccuracy), title: "Accuracy per framework", form: ChartForm.medium)
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["General audio classifier"]!), title: "Time to classify an image", form: ChartForm.medium, valueSpecifier: "%.4f")

                                    BarChartView(data: ChartData(values: fileSizeDict["General audio classifier"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)
                                }
                                Divider()
                            }
                        }
                    }.padding()

                    HStack{
                        VStack(alignment: .leading){
                            if trainingDict["General audio classifier 2"] != nil {
                                Text("General audio classifier 2").padding(.horizontal)
                                HStack{
                                    BarChartView(data: ChartData(values: trainingDict["General audio classifier 2"] ?? chartDataTimeToTrain), title: "Time to train in seconds", form: ChartForm.medium)
                                    BarChartView(data: ChartData(values: accuracyDict["General audio classifier 2"] ?? chartDataAccuracy), title: "Accuracy per framework", form: ChartForm.medium)
                                }
                                HStack{
                                    BarChartView(data: ChartData(values: timeDict["General audio classifier 2"] ?? chartDataTimeClassification), title: "Time to classify an image", form: ChartForm.medium, valueSpecifier: "%.4f")

                                    BarChartView(data: ChartData(values: fileSizeDict["General audio classifier 2"] ?? chartFileSizeData), title: "Model size in bytes", form: ChartForm.medium)
                                }
                                Divider()
                            }
                        }
                    }.padding()

                }
            }.navigationBarTitle("Statistics")
        }.onAppear {
            TestPersistence.getTests { (list, err) in
                self.trainingDict = [String:[(key: String, val: Int)]]()
                self.accuracyDict = [String:[(key: String, val: Double)]]()
                self.timeDict = [String:[(key: String, val: Double)]]()
                self.fileSizeDict = [String:[(key: String, val: Int)]]()
                
                for test in list {
                    switch test.trainedModel {
                    case "Car classifier":
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                    case "Object classification":
                        
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                    case "Cats vs dogs":
                        
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                        
                    case "Pokedex":
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                        
                    case "General audio classifier":
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                        print(self.timeDict[test.trainedModel])
                        
                    case "General audio classifier 2":
                        self.trainingDict[test.trainedModel] = (self.trainingDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.trainingTime)]
                        self.accuracyDict[test.trainedModel] = (self.accuracyDict[test.trainedModel] ?? self.chartDataAccuracy) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.accuracy * 100)]
                        self.timeDict[test.trainedModel] = (self.timeDict[test.trainedModel] ?? self.chartDataTimeClassification) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.classifyTime)]
                        self.fileSizeDict[test.trainedModel] = (self.fileSizeDict[test.trainedModel] ?? self.chartDataTimeToTrain) + [("\(test.name.split(separator: " ")[0]) \(test.name.split(separator: " ")[1])", test.modelSize)]
                        
                    default:
                        print(test.trainedModel)
                    }
                }
                self.tests = list
            }
        }
    }
    
}

struct modelComparison_Previews: PreviewProvider {
    static var previews: some View {
        ModelComparison()
    }
}
