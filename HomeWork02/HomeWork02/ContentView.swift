//
//  ContentView.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var newsVM: NewsViewModel = .init()
    @StateObject var navStackViewModel: CustomNavigationStackViewModel = .init()
    
    @State private var selected: NewsCategory = .first
    
    @State var isNeedPushView: Bool = true
    
    var body: some View {
        
        VStack {
            Text("Выберите новости")
                .font(.largeTitle)
            
            Picker("", selection: $selected) {
                Text(NewsCategory.first.title)
                    .tag(NewsCategory.first)
                
                Text(NewsCategory.second.title)
                    .tag(NewsCategory.second)
                
                Text(NewsCategory.third.title)
                    .tag(NewsCategory.third)
            }
            .pickerStyle(.segmented)
            
            .onChange(of: selected) { newValue in
                guard isNeedPushView else { isNeedPushView = true; return }
                let view = NewsView(category: newValue, nextView: nil).environmentObject(NewsViewModel(category: newValue))
                navStackViewModel.push(newValue.id, view)
                isNeedPushView = true
            }

            CustomNavigationStack(transition: .custom(AnyTransition.moveAndFade)) {
                NewsView(category: NewsCategory.first,
                         nextView: AnyView(NewsView(category: NewsCategory.second,
                                                    nextView: AnyView(NewsView(category: NewsCategory.third,
                                                                               nextView: nil)
                    .environmentObject(NewsViewModel(category: NewsCategory.third))))
                    .environmentObject(NewsViewModel(category: NewsCategory.second))))
                .environmentObject(NewsViewModel(category: NewsCategory.first))
            }
            .environmentObject(navStackViewModel)
            .onChange(of: navStackViewModel.current) { newValue in
                isNeedPushView = false
                selected = NewsCategory(rawValue: Int(newValue?.id ?? "") ?? 1) ?? .first
            }
            .onChange(of: selected) { newValue in
                isNeedPushView = true
            }
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
