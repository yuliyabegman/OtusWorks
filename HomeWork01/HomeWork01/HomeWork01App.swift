//
//  HomeWork01App.swift
//  HomeWork01
//
//  Created by Юлия Бегман on 06.03.2023.
//

import SwiftUI

@main
struct Homework001App: App {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
