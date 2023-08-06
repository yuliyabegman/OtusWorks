//
//  MainScreen.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject var mainViewModel: MainViewModel = .init()
    
    @State var selectedTab: Int = 0

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Constants.Colors.main.color)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Constants.Colors.main.color.opacity(0.5))
        UITabBar.appearance().backgroundColor = UIColor(Constants.Colors.main.color.opacity(0.4))
        UITabBar.appearance().barTintColor = .lightGray
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                SearchScreen(selectedTab: $selectedTab, artists: mainViewModel.artists)
                    .tag(0)
                    .tabItem {
                        Label("Поиск", systemImage: "person.fill.questionmark")
                    }
                
                ArtistsScreen(selectedTab: $selectedTab, artists: mainViewModel.artists)
                    .tag(1)
                    .tabItem {
                        Label("Художники", systemImage: "paintbrush")
                    }

                AboutScreen(selectedTab: $selectedTab)
                    .tag(2)
                    .tabItem {
                        Label("Инфо", systemImage: "camera.macro")
                    }
            }
            .accentColor(Constants.Colors.main.color)
        }
        .onAppear() {
            mainViewModel.loadArtists()
        }
    }
}

