
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
    @State var image = UIImage()
    @State var results = "No results"
//    @Binding var showingModal: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                Button(action: {
                    self.isShowingImagePicker.toggle()
                }) {
                    Text("Select image")
                }.sheet(isPresented: $isShowingImagePicker, content: {
                    ImagePickerView(isPresented: self.$isShowingImagePicker, image: self.$image)
                })
//                Button("Dismiss"){
//                    self.showingModal.toggle()
//                }
                Button(action: {
                    CoreMLImageClassification.updateClassifications(for: self.image)
                    self.results = CoreMLImageClassification.results
                    
                }) {
                    Text("Classify")
                }
                .disabled(self.image == UIImage())
                Text(results)
            }
        }
    }
    
    func classify(completed: () -> ()) {
        CoreMLImageClassification.updateClassifications(for: self.image)
        completed()
    }
}

struct TestDetail_Previews: PreviewProvider {
    static var previews: some View {
        TestDetail()
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
        return Coordinator(parent: self)
    }


    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        let parent: ImagePickerView
        init(parent: ImagePickerView){
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
                self.parent.image = selectedImage
            }
            self.parent.isPresented = false
        }

    }

    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {

    }
}
