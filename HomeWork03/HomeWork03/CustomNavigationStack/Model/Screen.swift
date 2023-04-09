//
//  Screen.swift
//  HomeWork03
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

 struct Screen: Identifiable, Equatable {

    let id: String
    let nextScreen: AnyView

    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

 
