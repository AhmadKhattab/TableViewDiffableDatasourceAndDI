//
//  Inject.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

@propertyWrapper
struct Inject<Type> {
    
    var value: Type
    var wrappedValue: Type {
        
        get {
            value
        }
        
        set {
            self.value = newValue
        }
    }
    
    init() {
        self.value = DIContainer.shared.resolve(serviceType: Type.self)
    }
    
}
