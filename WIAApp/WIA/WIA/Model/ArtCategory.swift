//
//  ArtCategory.swift
//  WIA
//
//  Created by Юлия Бегман on 13.08.2023.
//

// Категории для предварительной классификации изображений
enum ArtCategory: String, CaseIterable {
    case SculpturalPainting
    case NotValid
    case Unknown
    case Basrelief
    case BotanicalBasrelief
    case Flowers
    case Graphics
    case OilPainting
    case WatercolorPainting
    
    var title: String {
        switch self {
        case .Basrelief: return "Барельеф"
        case .BotanicalBasrelief: return "Ботанический барельеф"
        case .Flowers: return "Цветы"
        case .Graphics: return "Рисунок"
        case .NotValid: return "Не скульптурная живопись"
        case .OilPainting: return "Масляная живопись"
        case .SculpturalPainting: return "Скульптурная живопись"
        case .WatercolorPainting: return "Акварельная живопись"
        case .Unknown: return "Не удалось определить"
        }
    }
}
