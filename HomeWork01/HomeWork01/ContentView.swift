//
//  ContentView.swift
//  HomeWork01
//
//  Created by Юлия Бегман on 06.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
            
            TabView(selection: $selectedTab) {
                
                HomeScreen(selectedTab: $selectedTab)
                    .tag(0)
                    .tabItem {
                        Label("Главная", systemImage: "house")
                    }
                
                DetailScreen(selectedTab: $selectedTab, kind: "")
                    .tag(1)
                    .tabItem {
                        Label("Каталог", systemImage: "list.dash")
                    }
                
                AboutScreen(selectedTab: $selectedTab)
                    .tag(2)
                    .tabItem {
                        Label("О нас", systemImage: "person.2.crop.square.stack")
                    }
            }

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

