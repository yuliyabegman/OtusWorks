//
//  Int32.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI

extension Int {
    var color: Color {
        Color(.sRGB,
              red: Double((self >> 16) & 0xFF) / 255,
              green: Double((self >> 8) & 0xFF) / 255,
              blue: Double(self & 0xFF) / 255,
              opacity: 1
        )
    }
}
