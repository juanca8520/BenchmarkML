
//  TestDetail.swift
//  BenchmarkML
//
//  Created by Admin on 2/24/20.
//  Copyright © 2020 Universidad de Los Andes. All rights reserved.


import SwiftUI
import CoreML
import Vision
import ImageIO

struct TestDetail: View {
    @State var isShowingImagePicker = false
    @State var showingSheet = false
    @State var results = ""
    @State var imageLabelDictionary =  [UIImage : String]()
    @State var trainSetCount = 0
    
    @ObservedObject var obtainedResults: ObtainedResults = ObtainedResults()
    @ObservedObject var selectedImage: SelectedImage = SelectedImage()
    
    var model: Test?
    var isUpdatable: Bool
    
    var body: some View {
        ScrollView{
            VStack(alignment: HorizontalAlignment.leading){
                Text(model!.description)
                    .padding()
                
                HStack{
                    VStack {
                        Button(action: {
                            self.showingSheet.toggle()
                        }) {
                            if isUpdatable {
                                Text("Add image to classify or to train")
                            } else {
                                Text("Add image")
                            }
                        }.actionSheet(isPresented: self.$showingSheet) {
                            ActionSheet(title: Text("Select an option"), message: Text("Select how to add an image to classify"), buttons:
                                [.default(Text("Select from gallery"), action: {
                                    self.isShowingImagePicker.toggle()
                                }),
                                 .default(Text("Use camera"), action: {
                                    print("no lo tengo aun")
                                 }),
                                 .cancel()
                                ]
                            )
                        }
                        .sheet(isPresented: $isShowingImagePicker, content: {
                            ImagePickerView(isPresented: self.$isShowingImagePicker, image: self.$selectedImage.value)
                        }).padding(.horizontal)
                        
                        Button(action: {
                            self.imageLabelDictionary[self.selectedImage.value] = "Audi"
                            self.trainSetCount += 1
                            print(self.imageLabelDictionary)
                        }) {
                            Text("Add image to train set")
                                .disabled(selectedImage.value == UIImage())
                        }
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            print(self.model!.model)
                            switch self.model!.model {
                            case "CreateMLCarClassifier":
                                CreateMLCarClassifier(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "CreateMLCatVsDog":
                                CreateMLCatVsDog(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "CreateMLObjectClassifier":
                                CoreMLObjectClassifier(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "TuricreateCatVsDog":
                                TuricreateCatVsDog(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "TuricreateCarClassifier":
                                TuriCreateCarClassifier(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "KerasPokemonClassification":
                                KerasPokemonClassification(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "KerasCarClassifier":
                                KerasCarClassifier(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "CreateMLPokemonClassification":
                                CreateMLPokedex(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "TuricreatePokemonClassification":
                                TuricreatePokemonClassification(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            case "UpdatableKerasCarClassifier":
                                KerasUpdatableCarClassifier(obtainedResults: self.$results, trainSetCount: self.$trainSetCount).updateClassifications(for: self.selectedImage.value)
                            default:
                                print("holaaaa")
                            }
                        }) {
                            Text("Classify")
                                .padding(.horizontal)
                                .disabled(selectedImage.value == UIImage())
                        }
                        
                        Button(action: {
                            KerasUpdatableCarClassifier(obtainedResults: self.$results, trainSetCount: self.$trainSetCount).startTraining(imageLabelDictionary:  self.imageLabelDictionary)
                            self.imageLabelDictionary = [UIImage:String]()
                            self.selectedImage.value = UIImage()
                        }) {
                            Text("Train model")
                                .disabled(imageLabelDictionary == [UIImage : String]())
                        }
                    }
                }
                
                Text("Number of images to train the model: \(self.trainSetCount)")
                    .padding()
                
                HStack(alignment: .center){
                    Spacer()
                    Image(uiImage: selectedImage.value)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .overlay(
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color(UIColor.white.withAlphaComponent(0.75)))
                                Text(results)
                                    .foregroundColor(Color.black)
                            }.frame(width: 200, height: 200)
                                .padding(.horizontal), alignment: .bottomLeading)
                    Spacer()
                }
                
                
                Text("Time to train model:")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading){
                    if model!.trainingTime < 60{
                        Text("\(model!.trainingTime) seconds:")
                            .bold()
                            .padding(.top)
                            .padding(.horizontal)
                        
                    } else {
                        Text("\(model!.trainingTime/60) minutes \(model!.trainingTime % 60) seconds:")
                            .bold()
                            .padding(.top)
                            .padding(.horizontal)
                    }
                    
                    Text("With \(model!.numberElements) elements, \(model!.elementsPerLabel) for each label and \(model!.elementsForAccuracy) left for accuracy training")
                        .padding(.horizontal)
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarTitle(model!.name)
    }
}

struct TestDetail_Previews: PreviewProvider {
    static var previews: some View {
        TestDetail(model: landmarkData[0], isUpdatable: true)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var image: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self, image: self.$image)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        @Binding var image: UIImage
        init(parent: ImagePickerView, image: Binding<UIImage>){
            self._image = image
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
                self.image = selectedImage
            }
            self.parent.isPresented = false
        }
        
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}
