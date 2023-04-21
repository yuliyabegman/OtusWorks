//
//  SequenceViewModel.swift
//  HomeWork05
//
//  Created by Юлия Бегман on 19.04.2023.
//

import SwiftUI
import Combine

final class SequenceViewModel: ObservableObject {
    
    @Published var text: String = ""
    
    @Published var sequence: [SuffixSequence] = []
    
    @Published var topSuffixes: [Suffix] = []
    
    @Published var searchText = ""
    
    @Published var isTop: Bool = false
    
    @Published var isSortByAsc: Bool = true
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $text
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.setSequence(text, self?.isSortByAsc ?? true)
            })
            .store(in: &subscriptions)
        
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.selectSearchedSuffixes(text)
            })
            .store(in: &subscriptions)
    }
    
    func setSequence(_ text: String, _ isSortByAsc: Bool, _ topCount: Int = 10) {
        sequence = text
            .split(separator: " ")
            .compactMap({ SuffixSequence(word: String($0).lowercased(), isSortByAsc: isSortByAsc) })
        setSuffixFrequency()
        topSuffixes = getTopSuffixes(topCount)
    }
    
    func setSuffixFrequency() -> Void {
        let grouped = sequence
            .flatMap({ $0.suffixes })
            .reduce(into: [:]) { result, suffix in
                result[suffix.value, default: 0] += 1
            }
        
        sequence.forEach { suffixSequence in
            for suffix in suffixSequence.suffixes {
                suffix.frequency = grouped[suffix.value] ?? 0
                suffix.isSearched = suffix.value.contains(searchText.lowercased())
            }
        }
    }
    
    func getTopSuffixes(_ count: Int) -> [Suffix] {
        sequence
            .flatMap({ $0.suffixes })
            .filter({ $0.value.count == 3 })
            .unique()
            .sorted(by: { $0.frequency > $1.frequency})
            .prefix(count)
            .map({ $0 })
    }
    
    func selectSearchedSuffixes(_ text: String) {
        sequence.forEach({ sequence in sequence.suffixes.forEach({ $0.isSearched = $0.value.contains(text.lowercased()) }) })
    }
}
