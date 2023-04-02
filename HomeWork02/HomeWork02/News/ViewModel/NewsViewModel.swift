//
//  NewsViewModel.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 01.04.2023.
//

import SwiftUI
import Networking

final class NewsViewModel: ObservableObject {
    
    @Published var articles: [Article] = .init()
    @Published var searchText: String = ""
    @Published var fromDate: String = ""
    
    private var page = 1
    @State var finished = false
    @Published var canLoad = true
    
    private let apiKey = "b8ea6f87208f431ebe428725c45652cc" // "2ed2c11a2fa04b55b14fff672b7e175f"
    
    init(category: NewsCategory = .first) {
        fetch(searchText: category.title)
    }
    
    func fetch(searchText: String) {
        guard canLoad == true else { return }
        guard finished == false else { return }
        canLoad = false
        
        Task {
            ArticlesAPI.everythingGet(q: searchText,
                                      from: fromDate,
                                      sortBy: "publishedAt",
                                      language: "ru",
                                      apiKey: apiKey,
                                      page: page,
                                      completion: { [weak self] data, error in
                
                DispatchQueue.main.async { [weak self, data, error] in
                    if let error {
                        debugPrint(error)
                        self?.finished = true
                    } else {
                        self?.articles.append(contentsOf: data?.articles ?? [])
                        self?.page += 1
                        self?.canLoad = true
                        self?.finished = data?.totalResults ?? 0 >= self?.articles.count ?? 0
                    }
                }
            })
        }
        
    }
}
