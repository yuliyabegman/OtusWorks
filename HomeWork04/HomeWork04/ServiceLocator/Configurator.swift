//
//  Configurator.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 09.04.2023.
//

import CustomNavigation

final class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    func setup() {
        registerServices()
    }
    
    private func registerServices() {
        for category in NewsCategory.allCases {
            serviceLocator.register(NewsViewModel(category: category), category: category)
        }
        serviceLocator.register(CustomNavigationStackViewModel())
    }
}
