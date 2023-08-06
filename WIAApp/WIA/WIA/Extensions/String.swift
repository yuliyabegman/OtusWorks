//
//  String.swift
//  WIA
//
//  Created by Юлия Бегман on 31.07.2023.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
