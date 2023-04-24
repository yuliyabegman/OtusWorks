//
//  NewsCategory.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 02.04.2023.
//

import SwiftUI

public enum NewsCategory: Int, CaseIterable {
    case none = 0
    case first = 1
    case second = 2
    case third = 3
    
    var title: String {
        switch self {
        case .none: return ""
        case .first: return "Москва"
        case .second: return "Краснодар"
        case .third: return "Ростов"
        }
    }
    
    var description: String {
        switch self {
        case .none: return ""
        case .first: return "Новости Москвы"
        case .second: return "Новости Краснодара"
        case .third: return "Новости Ростова"
        }
    }
    
    var isShowPreviousButton: Bool {
        [.second, .third].contains(self)
    }
    
    var color: Color {
        switch self {
        case .none: return .clear
        case .first: return .teal
        case .second: return .pink
        case .third: return .cyan
        }
    }
    
    var next: NewsCategory {
        switch self {
        case .none: return .first
        case .first: return .second
        case .second: return .third
        case .third: return .none
        }
    }
    
    var id: String {
        "\(rawValue)"
    }
}
