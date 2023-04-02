//
//  ScreenStack.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

// Почему не работает с классом?

struct ScreenStack {
   
   private var screens: [Screen] = .init()
   
   func top() -> Screen? {
       screens.last
   }
   
   mutating func popToId(id: String) {
       var last = screens.last
       while !screens.isEmpty || last?.id != id  {
           last = screens.popLast()
       }
   }
   
   mutating func push(_ s: Screen) {
       screens.append(s)
   }
   
   mutating func popToPrevious() {
       _ = screens.popLast()
   }
   
   mutating func popToRoot() {
       screens.removeAll()
   }
   
}
