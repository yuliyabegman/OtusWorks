//
//  ImageView.swift
//  WIA
//
//  Created by Юлия Бегман on 06.08.2023.
//

import SwiftUI

struct ImageView<Content>: View where Content: Any {
    
    let image: Content
    var imageSize: CGFloat = UIScreen.main.bounds.width - 40
    
    @State private var selectedImage: Any? = nil
    @GestureState private var scale: CGFloat = 1.0
    
    var body: some View {
        HStack {
            showImage()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize, alignment: .center)
                .clipped()
        }
        .fullScreenCover(isPresented: Binding(get: { selectedImage != nil }, set: { _ in })) {
            HStack {
                showImage()
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .scaleEffect(scale)
                    .gesture(MagnificationGesture()
                        .updating($scale, body: { (value, scale, trans) in
                            scale = value.magnitude
                        })
                    )
            }
            .onTapGesture {
                selectedImage = nil
            }
        }
        .onTapGesture {
            selectedImage = image
        }
    }
    
    private func showImage() -> Image {
        if let imageName = image as? String {
            return Image(imageName)
        }
        else if let uiImage = image as? UIImage {
            return Image(uiImage: uiImage)
        }
        else {
            return Image(systemName: "photo")
        }
    }
}
