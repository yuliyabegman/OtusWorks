//
//  Configurator.swift
//  HomeWork03
//
//  Created by Юлия Бегман on 09.04.2023.
//

final class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    func setup() {
        registerServices()
    }
    
    private func registerServices() {
        for category in NewsCategory.allCases {
            serviceLocator.addService(NewsViewModel(category: category), category: category)
        }
        serviceLocator.addService(CustomNavigationStackViewModel())
    }
}
