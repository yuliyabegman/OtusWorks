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
    
    @Published var grouppedImageDatas: [ArtCategory : [ImageData]] = [:]
    
    // Анализ фото и определение художников
    func detect(_ images: [UIImage], _ artists: [Artist], _ completed: @escaping () -> Void) {
        guard !images.isEmpty,
              let preModel = try? VNCoreMLModel(for: SPPreClassifier(configuration: MLModelConfiguration()).model),
              let model = try? VNCoreMLModel(for: SPClassifier(configuration: MLModelConfiguration()).model) else {
            print("NO MODEL OR NO IMAGES")
            completed()
            return
        }
        
        self.imageDatas.removeAll()
        
        for image in images {
            let handler = VNImageRequestHandler(cgImage: image.cgImage!)
            try? handler.perform([getPreRequest(image, model, preModel, artists) {
                if image == images.last {
                    self.grouppedImageDatas = Dictionary(grouping: self.imageDatas) { data in
                        return data.category.type
                    }
                    
                    completed()
                }
            }])
        }
    }
    
    // Определить подходящие для анализа фото и группировать по категориям
    private func getPreRequest(_ image: UIImage,
                               _ model: VNCoreMLModel,
                               _ preModel: VNCoreMLModel,
                               _ artists: [Artist],
                               _ completed: @escaping () -> Void) -> VNCoreMLRequest {
        let request = VNCoreMLRequest(model: preModel) { response, error in
            if let categories = response.results as? [VNClassificationObservation] {
                self.detectCategory(image, categories, model, artists, completed)
            } else {
                completed()
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        return request
    }
    
    // Определить категорию изображения
    private func detectCategory(_ image: UIImage,
                                _ categories: [VNClassificationObservation],
                                _ model: VNCoreMLModel,
                                _ artists: [Artist],
                                _ completed: @escaping () -> Void) {
        
        let topCategories = categories.map{ ($0.identifier, Double($0.confidence)*100) }.filter({ $0.1.rounded(1) > 0 })
        
        if let topCategory = topCategories.max(by: { $0.1 < $1.1 }) {
            DispatchQueue.main.async {
                let category = Category(type: ArtCategory(rawValue: topCategory.0) ?? .Unknown, persent: topCategory.1.rounded(1))
                
                let imageData = ImageData(image: image, category: category, authors: [])
                
                self.imageDatas.append(imageData)
                
                if category.type == .SculpturalPainting {
                    self.detectArtists(image, model, artists) { data in
                        imageData.authors = data
                        completed()
                    }
                } else {
                    completed()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.imageDatas.append(ImageData(image: image, category: Category(), authors: []))
                completed()
            }
        }
    }
    
    // Определить художников
    private func detectArtists(_ image: UIImage,
                               _ model: VNCoreMLModel,
                               _ artists: [Artist],
                               _ completed: @escaping ([Author]) -> Void) {
        let request = VNCoreMLRequest(model: model) { response, error in
            if let authors = response.results as? [VNClassificationObservation] {
                var topAuthors = authors.map{ ($0.identifier, Double($0.confidence)*100) }.filter({ $0.1.rounded(1) > 0 })
                
                DispatchQueue.main.async {
                    topAuthors = topAuthors.filter({ $0.1 > 5 }).sorted{ $0.1 > $1.1 }
                    let authors = topAuthors.map({ author in Author(name: artists.first(where: { $0.className == author.0 })?.name ?? author.0, persent: author.1.rounded(1)) })
                    
                    completed(authors)
                }
            }
        }
        
        request.imageCropAndScaleOption = .centerCrop
        
        let handler = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler.perform([request])
    }
}
