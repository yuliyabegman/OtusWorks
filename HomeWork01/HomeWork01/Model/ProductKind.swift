//
//  ProductKind.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import Foundation
import SwiftUI

final class ProductKind: Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
    let color: Color
    
    internal init(title: String, color: Color) {
        self.title = title
        self.color = color
    }
}
