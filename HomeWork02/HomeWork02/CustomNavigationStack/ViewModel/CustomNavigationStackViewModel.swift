//
//  CustomNavigationStackViewModel.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

final public class CustomNavigationStackViewModel: ObservableObject {
    
    var customAnimation: Animation = .easeInOut(duration: 0.5)
    
    var navigationType: NavType = .push
    
    @Published var current: Screen?
    
    private var screenStack = ScreenStack() {
        didSet {
            current = screenStack.top()
        }
    }
    
    func push<S: View>(_ id: String, _ screenView: S) {
        withAnimation(customAnimation) {
            navigationType = .push
            
            screenStack.push(Screen(id: id, nextScreen: AnyView(screenView)))
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(customAnimation) {
            navigationType = .pop
            
            switch to {
            case .previous:
                screenStack.popToPrevious()
            case .root:
                screenStack.popToRoot()
            }
        }
    }
    
    func popToId(id: String) {
        screenStack.popToId(id: id)
    }
}
