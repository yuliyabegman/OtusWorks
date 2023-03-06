//
//  Product.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import Foundation

final class Product: Identifiable {
    
    let id: String = UUID().uuidString
    let kind: ProductKind
    let title: String
    let cost: Int
    let link: String
    
    internal init(kind: ProductKind, title: String, cost: Int, link: String) {
        self.kind = kind
        self.title = title
        self.cost = cost
        self.link = link
    }
}
