//
//  NavigationPushButton.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 01.04.2023.
//

import SwiftUI

public struct NavigationPushButton<Content, Destination>: View where Content: View, Destination: View {
    
    @EnvironmentObject var viewModel: CustomNavigationStackViewModel
    
    private let id: String
    private let destination: Destination
    private let content: Content
    
    public init(id: String, destination: Destination, @ViewBuilder content: @escaping ()->Content) {
        self.id = id
        self.destination = destination
        self.content = content()
    }
    
    public var body: some View {
        content.onTapGesture {
            push()
        }
    }
    
    private func push() {
        viewModel.push(id, destination)
    }
    
}
