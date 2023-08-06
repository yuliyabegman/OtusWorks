//
//  ArtistsScreen.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI

struct ArtistsScreen: View {
    
    @Binding var selectedTab: Int
    @State var selectedArtist: Artist?
    
    let artists: [Artist]
    
    var body: some View {
        VStack {
            if let selectedArtist {
                ScrollView(showsIndicators: false) {
                    ArtistView(artist: selectedArtist)
                        .padding()
                }
            } else {
                HStack(spacing: 10) {
                    Text("Кто работает в технике скульптурной живописи?")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(Constants.Colors.main.color)
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider().frame(height: 1).background(Constants.Colors.main.color)
                
                ScrollView {
                    ForEach(artists) { artist in
                        ArtistView(artist: artist)
                            .padding(20)
                        
                        Divider().frame(height: 1).background(Constants.Colors.main.color)
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 1)
        .onAppear() {
            selectedTab = 1
        }
    }
}
