//
//  ServiceLocator.swift
//  HomeWork04
//
//  Created by Юлия Бегман on 09.04.2023.
//

protocol ServiceLocating {
    func resolve<T>() -> T?
    func resolve<T>(for category: NewsCategory?) -> T
}

final class ServiceLocator: ServiceLocating {
    
    public static var shared = ServiceLocator()
    
    private lazy var services: Dictionary<String, Any> = [:]
    
    private func getTypeName(_ obj: Any, category: NewsCategory? = nil) -> String {
        switch obj {
        case is NewsViewModel:
            if let id = category?.id {
                return "\(type(of: obj))_\(id)"
            } else {
                return "\(obj)"
            }
        default:
            return "\(type(of: obj))"
        }
    }
    
    func register<T>(_ service: T) {
        let key = getTypeName(service)
        services[key] = service
    }
    
    func register<T>(_ service: T, category: NewsCategory) {
        let key = getTypeName(service, category: category)
        services[key] = service
    }
    
    func resolve<T>()->T? {
        let key = String.init(describing: T.self)
        return services[key] as? T
    }
    
    func resolve<T>(for category: NewsCategory? = nil) -> T {
        var key: String
        if let id = category?.id {
            key = "\(String.init(describing: T.self))_\(id)"
        } else {
            key = String.init(describing: T.self)
        }
        return services[key] as! T
    }
}
