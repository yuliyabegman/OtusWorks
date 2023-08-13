//
//  Category.swift
//  WIA
//
//  Created by Юлия Бегман on 13.08.2023.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    
    let id: String = UUID().uuidString
    var type: ArtCategory = .Unknown
    var persent: Double = 0
    
    internal init(type: ArtCategory = .Unknown, persent: Double = 0) {
        self.type = type
        self.persent = persent
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}
