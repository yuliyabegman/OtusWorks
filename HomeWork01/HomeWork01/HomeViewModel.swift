//
//  HomeViewModel.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    internal init(products: [Product] = []) {
        
        if products.isEmpty {
            let paints = ProductKind(title: "Краски", color: .pink)
            let brushes = ProductKind(title: "Кисти", color: .brown)
            let paper = ProductKind(title: "Бумага", color: .teal)
            
            self.products = [
                Product(kind: paints, title: "Белый", cost: 150, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: paints, title: "Охра", cost: 250, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: paints, title: "Неоновый", cost: 350, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: paints, title: "Тиана", cost: 450, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: paints, title: "Синий", cost: 550, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: paints, title: "Алый", cost: 650, link: "https://krasniykarandash.ru/kraski/"),
                Product(kind: brushes, title: "Белка 1", cost: 50, link: "https://krasniykarandash.ru/kisti/"),
                Product(kind: brushes, title: "Белка 2", cost: 60, link: "https://krasniykarandash.ru/kisti/"),
                Product(kind: brushes, title: "Белка 3", cost: 70, link: "https://krasniykarandash.ru/kisti/"),
                Product(kind: brushes, title: "Белка 4", cost: 80, link: "https://krasniykarandash.ru/kisti/"),
                Product(kind: brushes, title: "Белка 5", cost: 90, link: "https://krasniykarandash.ru/kisti/"),
                Product(kind: paper, title: "Акварельная", cost: 390, link: "https://krasniykarandash.ru/bumaga_karton_penokarton/bumaga_dlya_akvareli/"),
                Product(kind: paper, title: "Картон", cost: 490, link: "https://krasniykarandash.ru/bumaga_karton_penokarton/bumaga_dlya_akvareli/"),
                Product(kind: paper, title: "Синтетическая", cost: 590, link: "https://krasniykarandash.ru/bumaga_karton_penokarton/bumaga_dlya_akvareli/"),
                Product(kind: paper, title: "Пергаментная", cost: 690, link: "https://krasniykarandash.ru/bumaga_karton_penokarton/bumaga_dlya_akvareli/"),
                Product(kind: paper, title: "Тишью", cost: 790, link: "https://krasniykarandash.ru/bumaga_karton_penokarton/bumaga_dlya_akvareli/")
            ]
        } else {
            self.products = products
        }
    }
}
