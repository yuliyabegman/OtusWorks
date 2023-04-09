//
//  News.swift
//  HomeWork03
//
//  Created by Юлия Бегман on 01.04.2023.
//

import SwiftUI
import Networking

struct NewsView: View {
    
    @EnvironmentObject var newsVM: NewsViewModel
    
    let category: NewsCategory
    let nextView: AnyView?
    
    @State var hiddenArticles: Set<String> = Set<String>()
    var visibleArticles: [Article] {
        return newsVM.articles.filter({ acticle in !hiddenArticles.contains(where: { $0 == acticle.url }) })
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text(category.description)
                .font(.largeTitle)
            
            if newsVM.articles.isEmpty && !newsVM.canLoad {
                Spacer()
                ProgressView()
                    .tint(.pink)
                Spacer()
            } else {
                getList(for: category)
            }
            
            Divider()
            
            HStack {
                if category.isShowPreviousButton {
                    NavigationPopButton(destination: .previous) {
                        Text("Назад")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color.pink)
                            .cornerRadius(14)
                    }
                }
                
                if nextView != nil {
                    NavigationPushButton(id: category.next.id ,destination: nextView!) {
                        Text("Вперед")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color.mint)
                            .cornerRadius(14)
                    }
                } else {
                    NavigationPopButton(destination: .root) {
                        Text("В начало")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color.cyan)
                            .cornerRadius(14)
                    }
                }
            }
            .padding()
        }
    }
    
    private func getList(for category: NewsCategory) -> some View {
        List(visibleArticles) { article in
            ListArticleCell(title: article.title ?? article.description ?? "",
                            content: article.description ?? "",
                            borderColor: category.color) {
                hiddenArticles.insert(article.url)
            }
                            .listRowSeparator(.hidden)
                            .onAppear {
                                if newsVM.articles.isLastItem(article) {
                                    newsVM.fetch(searchText: category.title)
                                }
                            }
                            .showActivityIdicator(
                                !newsVM.canLoad && !newsVM.finished && newsVM.articles.last == article
                            )
        }
        .scrollContentBackground(.hidden)
    }
    
    private func getListArticleCell(title: String, content: String, borderColor: Color) -> some View {
        
        VStack {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .padding()
                
                Divider().frame(height: 1).background(borderColor)
                
                Text(content)
                    .foregroundColor(.black)
                    .lineLimit(6)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(borderColor.opacity(0.1))
            .cornerRadius(14)
        }
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(borderColor, lineWidth: 1)
        }
        
    }
    
}

struct ListArticleCell: View {
    let title: String
    let content: String
    let borderColor: Color
    let onTapped: () -> Void
    
    @State var hideCell: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .padding()
                
                Divider().frame(height: 1).background(borderColor)
                
                Text(content)
                    .foregroundColor(.black)
                    .lineLimit(6)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(borderColor.opacity(0.1))
            .cornerRadius(14)
        }
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(borderColor, lineWidth: 1)
        }
        .onAppear() {
            hideCell = false
        }
        .onTapGesture {
            withAnimation {
                hideCell.toggle()
                onTapped()
            }
        }
        .rotationEffect(.degrees(hideCell ? -160 : 0))
        .opacity(hideCell ? 0 : 1)
        .offset(x: hideCell ? 500 : 0, y: hideCell ? 2000 : 0)
        .animation(.easeOut(duration: 5), value: hideCell)
    }
}
