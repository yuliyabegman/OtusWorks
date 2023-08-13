//
//  SearchScreen.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI
import Charts
import PhotosUI

struct SearchScreen: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    
    @Binding var selectedTab: Int
    
    let artists: [Artist]
    
    @State private var selectedItems: [PhotosPickerItem] = []
    
    @State private var images: [UIImage] = []
    
    @State private var isShowProgress: Bool = false
    
    var body: some View {
            VStack {
                HStack(spacing: 10) {
                    Text("Кто автор?")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(Constants.Colors.main.color)
                    Spacer()
                    
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 30, matching: .images) {
                        Image(systemName: "photo.on.rectangle.angled")
                    }
                    .onChange(of: selectedItems) { newItems in
                        Task {
                            isShowProgress = true
                            removeImages()
                            
                            for newItem in newItems {
                                if let data = try? await newItem.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        images.append(image)
                                    }
                                }
                            }
                            
                            searchViewModel.detect(images, artists) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    isShowProgress = false
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if !images.isEmpty {
                        Button {
                            removeImages()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                }
                .padding()
                
                Divider().frame(height: 1).background(Constants.Colors.main.color)
                
                ZStack {
                    if !searchViewModel.grouppedImageDatas.isEmpty && !isShowProgress {
                        ScrollView {
                            if let datas = searchViewModel.grouppedImageDatas[.SculpturalPainting] {
                                ForEach(datas, id: \.self) { data in
                                    showImageData(data)
                                }
                            }
                            
                            if searchViewModel.grouppedImageDatas.contains(where: { $0.key != .SculpturalPainting && !$0.value.isEmpty }) {
                                HStack {
                                    Text("На этих фото нет изображения скульптурной живописи")
                                        .fontWeight(.semibold)
                                        .font(.title)
                                        .foregroundColor(Constants.Colors.main.color)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                ForEach(ArtCategory.allCases.filter({ $0 != .SculpturalPainting }), id: \.self) { category in
                                    if let datas = searchViewModel.grouppedImageDatas[category] {
                                        if [.NotValid, .Unknown].contains(category) {
                                            ScrollView(.horizontal) {
                                                HStack {
                                                    ForEach(datas, id: \.self) { data in
                                                        ImageView(image: data.image, imageSize: 100)
                                                            .cornerRadius(10.0)
                                                            .clipped()
                                                    }
                                                }
                                                .padding()
                                            }
                                        } else {
                                            ForEach(datas, id: \.self) { data in
                                                showNotValidImageData(data)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        VStack {
                            Text(isShowProgress
                                 ? "Ищем автора..."
                                 : "Для определения авторства работы художника скульптурной живописи выберите одну или несколько фотографий")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(20)
                            Spacer()
                        }
                    }
                    
                    if isShowProgress {
                        VStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(.circular)
                                .accentColor(Constants.Colors.main.color)
                                .scaleEffect(2)
                            Spacer()
                        }
                    }
                }
                .padding(1)
        }
    }
    
    private func removeImages() {
        selectedItems.removeAll()
        images.removeAll()
        searchViewModel.imageDatas.removeAll()
        searchViewModel.grouppedImageDatas.removeAll()
    }
    
    private func showImageData(_ data: ImageData) -> some View {
        VStack {
            if !data.authors.isEmpty {
                HStack {
                    VStack {
                        ImageView(image: data.image, imageSize: 150)
                            .cornerRadius(10.0)
                            .clipped()
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(data.authors) { author in
                            NavigationLink {
                                ArtistsScreen(selectedTab: Binding(get: {1}, set: {_ in}),
                                              selectedArtist: artists.first(where: {$0.name == author.name }),
                                              artists: artists)
                            } label: {
                                HStack(alignment: .top, spacing: 0) {
                                    Spacer()
                                    Text("\(author.persent.roundedS(1))%")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.trailing)
                                    Text(" - \(author.name)")
                                }
                                .font(.system(size: 15))
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                
                Divider().frame(height: 1).background(Constants.Colors.main.color)
            }
        }
    }
    
    private func showNotValidImageData(_ data: ImageData) -> some View {
        VStack {
            HStack {
                VStack {
                    ImageView(image: data.image, imageSize: 150)
                        .cornerRadius(10.0)
                        .clipped()
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Text("\(data.category.persent.roundedS(1))% - \(data.category.type.title)")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.trailing)
                    Spacer()
                }
            }
            .padding()
            
            Divider().frame(height: 1).background(Constants.Colors.main.color)
        }
    }
}
