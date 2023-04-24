//
//  CustomNavigationStack.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 31.03.2023.
//

import SwiftUI

public struct CustomNavigationStack<Content>: View where Content: View {
    
    @EnvironmentObject var viewModel: CustomNavigationStackViewModel
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public var easing: Animation {
        get {
            viewModel.customAnimation
        }
        set {
            viewModel.customAnimation = newValue
        }
    }
    
    public init(transition: NavTransition,
                easing: Animation = .easeInOut(duration: 0.33),
                @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        
        switch transition {
        case .custom(let t):
            self.transitions = (t, t)
        case .none:
            self.transitions = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.current == nil
        
        return ZStack {
            if isRoot {
                content
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            } else {
                viewModel.current?.nextScreen
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            }
        }
        
    }
    
}
