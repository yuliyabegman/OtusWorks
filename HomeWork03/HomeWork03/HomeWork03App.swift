//
//  HomeWork03App.swift
//  HomeWork03
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

@main
struct HomeWork03App: App {
    
    init() {
        Configurator.shared.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
