//
//  ImageData.swift
//  WIA
//
//  Created by Юлия Бегман on 29.07.2023.
//

import SwiftUI

final class ImageData: Identifiable, Hashable {
    
    let id: String = UUID().uuidString
    @Published var image: UIImage
    @Published var category: Category
    @Published var authors: [Author]
  
    internal init(image: UIImage, category: Category = Category(), authors: [Author] = []) {
        self.image = image
        self.category = category
        self.authors = authors
    }
    
    static func == (lhs: ImageData, rhs: ImageData) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
