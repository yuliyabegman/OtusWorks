//
//  Artist.swift
//  WIA
//
//  Created by Юлия Бегман on 23.07.2023.
//

import SwiftUI

class Artist: Identifiable {
    var id: String = UUID().uuidString
    var className: String = ""
    var name: String = ""
    var place: String = ""
    var avatar: String = ""
    var bio: String = ""
    var links: [String] = []
    var images: [String] = []
    
    internal init(className: String = "", name: String = "", place: String = "", avatar: String = "", bio: String = "", links: [String] = [], images: [String] = []) {
        self.className = className
        self.name = name
        self.place = place
        self.avatar = avatar
        self.bio = bio
        self.links = links
        self.images = images
    }
}

