//
//  HomeWork04App.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

@main
struct HomeWork04App: App {
    
    init() {
        Configurator.shared.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
