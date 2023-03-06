//
//  DetailScreen.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var selectedTab: Int
    
    let kind: String
    
    var products: [Product] {
        guard !kind.isEmpty else { return homeViewModel.products }
        
        return homeViewModel.products.filter({ $0.kind.title == kind })
    }
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geo in
                
                VStack {
                    
                    Text(kind.isEmpty ? "Каталог" : kind)
                        .font(.largeTitle)
                    
                    NavigationView {
                        List {
                            
                            headerView(geo.size.width)
                            
                            ForEach(products) { product in
                                NavigationLink {
                                    BrowserScreen(link: product.link)
                                } label: {
                                    HStack {
                                        Text(product.title)
                                            .font(.subheadline)
                                            .frame(width: geo.size.width/3, alignment: .leading)
                                        
                                        Divider()
                                        
                                        Text(product.kind.title)
                                            .font(.subheadline)
                                            .foregroundColor(product.kind.color)
                                        
                                        Spacer()
                                        Divider()
                                        
                                        Text("\(product.cost) руб.")
                                            .font(.subheadline)
                                            .frame(width: geo.size.width/6, alignment: .trailing)
                                    }
                                }
                            }
                        }
                        .listStyle(.grouped)
                    }
                    
                    Spacer()
                }
            }
            .onAppear() {
                selectedTab = 1
            }
        }
    }
    
    func headerView(_ width: CGFloat) -> some View {
        
        HStack {
            Text("Товар")
                .fontWeight(.semibold)
                .frame(width: width/3, alignment: .leading)
            
            Divider()
            
            Text("Тип")
                .fontWeight(.semibold)
            
            Spacer()
            Divider()
            
            Text("Цена")
                .fontWeight(.semibold)
                .frame(width: width/6, alignment: .trailing)
                .padding(.trailing, 20)
        }
        .font(.headline)
        
    }
}
