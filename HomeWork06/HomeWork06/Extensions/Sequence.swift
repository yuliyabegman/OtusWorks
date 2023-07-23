//
//  Sequence.swift
//  HomeWork
//
//  Created by Юлия Бегман on 20.04.2023.
//

extension Sequence where Iterator.Element == Suffix {
    func unique() -> [Iterator.Element] {
        var values: Set<String> = []
        return filter { values.insert($0.value).inserted }
    }
}
