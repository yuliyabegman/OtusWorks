//
//  SuffixSequence.swift
//  HomeWork
//
//  Created by Юлия Бегман on 18.04.2023.
//

import Foundation

final class SuffixSequence: Sequence {
    var word: String
    var suffixes: [Suffix] = []
    var isSortByAsc: Bool = true
    
    init(word: String, isSortByAsc: Bool) {
        self.word = word
        self.suffixes = self.compactMap({ $0 as? Suffix })
            .sorted(by: { lhs, rhs in
                isSortByAsc ? lhs.value < rhs.value : rhs.value < lhs.value
            })
        self.isSortByAsc = isSortByAsc
    }
    
    func makeIterator() -> some IteratorProtocol {
        return SuffixIterator(word: word)
    }
}
