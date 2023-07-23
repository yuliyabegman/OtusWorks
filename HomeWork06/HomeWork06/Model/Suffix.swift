//
//  Suffix.swift
//  HomeWork
//
//  Created by Юлия Бегман on 19.04.2023.
//

import Foundation

final class Suffix: Hashable, Identifiable {
    var id = UUID().uuidString
    var value: String = ""
    var frequency: Int = 0
    var isSearched: Bool = false
    
    init(value: String) {
        self.value = value
        self.frequency = 0
    }
    
    static func == (lhs: Suffix, rhs: Suffix) -> Bool {
        lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(value)
    }
}
