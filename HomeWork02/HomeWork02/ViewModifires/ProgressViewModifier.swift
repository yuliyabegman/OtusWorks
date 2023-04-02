//
//  ProgressViewModifier.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 02.04.2023.
//

import SwiftUI

struct ProgressViewModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        if !isLoading {
            content
        } else {
            VStack {
                content
                HStack {
                    Spacer()
                    ProgressView()
                        .tint(.pink)
                    Spacer()
                }
            }
        }
    }
}
