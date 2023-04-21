//
//  Suffix.swift
//  HomeWork05
//
//  Created by Юлия Бегман on 19.04.2023.
//

import Foundation

final class Suffix: Hashable, Identifiable {
    var id = UUID().uuidString
    var value: String = ""
    var frequency: Int = 0
    var isSearched: Bool = false
    
    var frequencyText: String {
        frequency > 0 ? "\(frequency) раз" : "-" 
    }
    
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
