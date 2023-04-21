//
//  SuffixIterator.swift
//  HomeWork05
//
//  Created by Юлия Бегман on 18.04.2023.
//

import Foundation


final class SuffixIterator: IteratorProtocol {
    var word: String
    var index: Int = 0
    
    init(word: String) {
        self.word = word
    }
   
    func next() -> Suffix? {
        guard index < word.count else { return nil }
        
        let suffix = String(word.dropFirst(index))
        index += 1
        
        return Suffix(value: suffix)
    }
    
}
