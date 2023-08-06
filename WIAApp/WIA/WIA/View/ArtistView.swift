//
//  ArtistView.swift
//  WIA
//
//  Created by Юлия Бегман on 31.07.2023.
//

import SwiftUI

struct ArtistView: View {
    let artist: Artist
    
    private let imageSize: CGFloat = UIScreen.main.bounds.width - 40
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(artist.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                }
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(100)
                .clipped()
                
                VStack(alignment: .leading) {
                    Text(artist.name)
                        .font(.title)
                    Text(artist.place)
                        .font(.subheadline)
                }
                
                Spacer()
            }
            
            Text(artist.bio)
                .font(.system(size: 15))
                .padding(.vertical)
            
            TabView() {
                ForEach(artist.images, id: \.self) { imageName in
                    ImageView(image: imageName)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: imageSize)
            
            VStack {
                ForEach(artist.links) { link in
                    if let url = URL(string: link) {
                        HStack {
                            Link("Контакты", destination: url)
                                .font(.title3)
                                .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
    }
}
