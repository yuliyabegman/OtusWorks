//
//  Article.swift
//  HomeWork02
//
//  Created by Юлия Бегман on 01.04.2023.
//

import Networking

extension Article: Identifiable {
    public var id: String { url }
}
