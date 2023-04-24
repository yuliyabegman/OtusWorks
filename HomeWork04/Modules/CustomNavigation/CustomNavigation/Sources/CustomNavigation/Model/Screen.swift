//
//  Screen.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

public struct Screen: Identifiable, Equatable {

    public let id: String
    let nextScreen: AnyView

    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

 
