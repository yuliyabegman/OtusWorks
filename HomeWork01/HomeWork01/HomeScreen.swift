//
//  HomeScreen.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                NavigationLink(destination: DetailScreen(selectedTab: $selectedTab, kind: "")) {
                    Text("Все товары")
                        .font(.title)
                }
                
                NavigationLink(destination: DetailScreen(selectedTab: $selectedTab, kind: "Краски")) {
                    Text("Краски")
                        .font(.title)
                }
                
                NavigationLink(destination: DetailScreen(selectedTab: $selectedTab, kind: "Кисти")) {
                    Text("Кисти")
                        .font(.title)
                }
                
                NavigationLink(destination: DetailScreen(selectedTab: $selectedTab, kind: "Бумага")) {
                    Text("Бумага")
                        .font(.title)
                }
            }
        }
        .onAppear() {
            selectedTab = 0
        }
               
    }
}
