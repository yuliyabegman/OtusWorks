//
//  Author.swift
//  WIA
//
//  Created by Юлия Бегман on 29.07.2023.
//

import SwiftUI

struct Author: Identifiable, Hashable {
    let id: String = UUID().uuidString
    var name: String = ""
    var persent: Double = 0
    
    internal init(name: String = "", persent: Double = 0) {
        self.name = name
        self.persent = persent
    }
    
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
}
