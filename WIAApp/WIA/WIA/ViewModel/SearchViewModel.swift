//
//  SearchViewModel.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI
import CoreML
import Vision

final class SearchViewModel: ObservableObject {
    
    @Published var imageDatas: [ImageData] = []
    
    func detect(_ images: [UIImage], _ artists: [Artist], _ completed: @escaping () -> Void) {
        guard !images.isEmpty, let model = try? VNCoreMLModel(for: SPClassifier(configuration: MLModelConfiguration()).model) else {
            print("NO MODEL")
            completed()
            return
        }
        
        self.imageDatas.removeAll()
        
        for image in images {
            let request = VNCoreMLRequest(model: model) { response, error in
                if let authors = response.results as? [VNClassificationObservation] {
                    var topAuthors = authors.map{ ($0.identifier, Double($0.confidence)*100) }.filter({ $0.1.rounded(1) > 0 })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        topAuthors = topAuthors.sorted{ $0.1 > $1.1 }
                        
                        let authors = topAuthors.map({ author in Author(name: artists.first(where: { $0.className == author.0 })?.name ?? author.0, persent: author.1.rounded(1)) })
                        let imageData = ImageData(image: image, authors: authors)
                        
                        self.imageDatas.append(imageData)
                        if image == images.last { completed() }
                    }
                }
            }
            
            request.imageCropAndScaleOption = .centerCrop
            
            let handler = VNImageRequestHandler(cgImage: image.cgImage!)
            try? handler.perform([request])
        }
    }
}
