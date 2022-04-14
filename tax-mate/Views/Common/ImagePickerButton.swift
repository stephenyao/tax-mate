//
//  ImagePickerButton.swift
//  TaxDeducer
//
//  Created by Stephen Yao on 15/1/21.
//

import SwiftUI

struct ImagePickerButton: View {
    @State private var photoPickerPresented = false
    @State private var showingActions = false
    @State private var sourceType: UIImagePickerController.SourceType?
    @Binding var image: UIImage?
    
    var body: some View {
        HStack {
            if let image = self.image {
                ZStack(alignment: .topLeading) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.showingActions = true
                            }
                        Button(action: { self.image = nil }) {
                            Image(systemName: "xmark")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Circle().foregroundColor(.black))
                        }
                    
                        .offset(x: -13, y: -13)
                }
                .frame(width: 120, height: 360)
                .background(Color.red)
            } else {
                Button {
                    showingActions = true
                } label: {
                    VStack {
                        Image(systemName: "doc.text.image")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.theme)
                            .frame(width: 44, height: 44)
                        
                        Text("Add photo")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.theme)
                }
            }
        }
        .actionSheet(isPresented: $showingActions) {
            ActionSheet(
                title: Text("Upload from"), buttons: [
                    .default(Text("Camera")) {
                        self.sourceType = .camera
                        self.photoPickerPresented = true
                    },
                    .default(Text("Photo Library")) {
                        self.sourceType = .photoLibrary
                        self.photoPickerPresented = true
                    },
                    .cancel()
                ])
        }
        .fullScreenCover(isPresented: $photoPickerPresented) {
            if let sourceType = sourceType {
                ImagePicker(sourceType: sourceType, selectedImage: self.$image)
                    .ignoresSafeArea()
                    .accentColor(.primary)
            }
        }
    }
}

private struct ImagePickerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cornerRadius(8.0)
        
    }
}

private struct Preview: View {
    @State var image: UIImage?
    
    var body: some View {
        ImagePickerButton(image: $image)
    }
}

struct ImagePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
