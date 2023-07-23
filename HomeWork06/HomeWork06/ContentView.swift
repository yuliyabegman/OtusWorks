//
//  ContentView.swift
//  HomeWork
//
//  Created by Юлия Бегман on 18.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        SequenceView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "ru"))
    }
}
