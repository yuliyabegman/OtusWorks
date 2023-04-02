//
//  Enum.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

enum NavType {
    case push
    case pop
    case byId
}

public enum PopDestination {
    case previous
    case root
}

public enum NavTransition {
    case none
    case custom(AnyTransition)
}
