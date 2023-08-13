//
//  MainViewModel.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    @Published var image: UIImage = UIImage()
    
    @Published var artists: [Artist] = []
    
    func loadArtists() {
        artists = parseCSV(fileName: "artists.csv")
    }
 
    private func parseCSV(fileName: String) -> [Artist] {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: nil) {
            do {
                let fileContent = try String(contentsOfFile: filepath)
                let lines = fileContent.components(separatedBy: "\n")
                
                var results: [Artist] = []
                
                lines.dropFirst().forEach { line in
                    let data = line.components(separatedBy: ";")
                    if !line.isEmpty {
                        let artist = Artist()
                        artist.className = data[0]
                        artist.name = data[1]
                        artist.place = data[2]
                        artist.links = data[3].components(separatedBy: ",")
                        artist.bio = data[4]
                        artist.avatar = artist.className
                        artist.images = Array(0...50).compactMap({ number in
                            let imageName = "\(artist.className)_\(number)"
                            if let _ = UIImage(named: imageName) {
                                return imageName
                            } else {
                                return nil
                            }
                        })
                        results.append(artist)
                    }
                }
                return results.sorted(by: { $0.name < $1.name })
                
            } catch {
                print("error: \(error)")
            }
        } else {
            print("\(fileName) could not be found")
        }
        
        return []
    }
}
