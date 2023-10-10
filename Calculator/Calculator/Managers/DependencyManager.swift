//
//  DependencyManager.swift
//  Calculator
//
//  Created by Alexey Kachura on 10.10.23.
//

import Foundation

struct DependencyManager {
    private static var dependencies = [String: Any]()
    
    static func register<T>(dependency: T) {
        dependencies[String(describing: T.self)] = dependency
    }
    
    static func resolve<T>() -> T {
        let type = T.self
        guard let dependency = dependencies[String(describing: type)] as? T else {
            fatalError("No such dependecy found: \(type)")
        }
        
        return dependency
    }
}

@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyManager.register(dependency: wrappedValue)
    }
}

@propertyWrapper struct Inject<T> {
    var wrappedValue: T
    
    init() {
        wrappedValue = DependencyManager.resolve()
    }
}
