//
//  NavigationPopButton.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 01.04.2023.
//

import SwiftUI

public struct NavigationPopButton<Content>: View where Content: View {
    
    @EnvironmentObject var viewModel: CustomNavigationStackViewModel
    
    private let destination: PopDestination
    private let content: Content
    
    public init(destination: PopDestination, @ViewBuilder content: @escaping ()->Content) {
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
    
}
