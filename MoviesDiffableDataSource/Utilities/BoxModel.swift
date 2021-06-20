//
//  BoxModel.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

class BoxModel<Wrappee> {
    
    typealias Handler = (Wrappee) -> Void
    var handler: Handler?
    var value: Wrappee? {
        
        didSet {
            
            guard let safeValue = value else { return }
            
            handler?(safeValue)
        }
    }
    

    init(value: Wrappee?) {
        self.value = value
    }
    
    
    func bind(handler: Handler?) {
        
        self.handler = handler
        
        guard let safeValue = value else { return }
        
        handler?(safeValue)
    }
}
