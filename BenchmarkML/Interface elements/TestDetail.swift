
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
    @State var image = UIImage()
    @State var results = ""
    
    @ObservedObject var obtainedResults: ObtainedResults = ObtainedResults()
    @ObservedObject var selectedImage: SelectedImage = SelectedImage()
    
    var model: Test?
    
    var body: some View {
        ScrollView{
            VStack(alignment: HorizontalAlignment.leading){
                Text(model!.description)
                    .padding()
                
                HStack{
                    Button(action: {
                        self.showingSheet.toggle()
                    }) {
                        Text("Add image")
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
                    }).padding()
                    Spacer()
                    Button(action: {
                        print(self.model!.model)
                        switch self.model!.model {
                        case "CreateMLCarClassifier":
                            self.obtainedResults.objectWillChange.send()
                            CoreMLImageClassification(obtainedResults: self.$results).updateClassifications(for: self.selectedImage.value)
                            self.obtainedResults.objectWillChange.send()
                            print(self.obtainedResults.value)
                        case "CreateMLObjectClassifier":
                            CoreMLObjectClassifier.updateClassifications(for: self.image)
                            self.results = CoreMLObjectClassifier.results
                        case "TuricreateCatVsDog":
                            TuricreateCatVsDog.updateClassifications(for: self.image)
                            self.results = TuricreateCatVsDog.results
                        default:
                            print("hola")
                        }
                    }) {
                        Text("Classify")
                            .padding(.horizontal)
                            .disabled(selectedImage.value == UIImage())
                    }
                }
                
                
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
                    Text("\(model!.trainingTime) seconds:")
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text("With \(model!.numberElements) elements, \(model!.elementsPerLabel) for each label and \(model!.elementsForAccuracy) left for accuracy training")
                        .padding(.horizontal)
                    Text(self.obtainedResults.value).foregroundColor(Color.white)

                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarTitle(model!.name)
    }
    
    func classify(completed: () -> ()) {
        //        CoreMLImageClassification.updateClassifications(for: self.image, with: )
        //        completed()
    }
}

struct TestDetail_Previews: PreviewProvider {
    static var previews: some View {
        TestDetail(model: landmarkData[0])
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
