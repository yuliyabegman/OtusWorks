//
//  View.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 02.04.2023.
//

import SwiftUI

extension View {
    func showActivityIdicator(_ value: Bool) -> some View {
        modifier(ProgressViewModifier(isLoading: value))
    }
}
