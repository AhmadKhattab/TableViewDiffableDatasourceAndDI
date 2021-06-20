//
//  DIContainer.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

protocol DIContainerProtocol {

    var dependenciesFactory: [String:() -> Any] { get set }
    func register<Service>(serviceType: Service.Type, _ dependencyFactory: @escaping () -> Service)
    func resolve<Service>(serviceType: Service.Type) -> Service
    
}

class DIContainer: DIContainerProtocol {
    
    static let shared = DIContainer()
    var dependenciesFactory: [String : () -> Any] = [ : ]
    
    func register<Service>(serviceType: Service.Type, _ dependencyFactory: @escaping () -> Service) {
        dependenciesFactory["\(serviceType)"] = dependencyFactory
    }
    
    func resolve<Service>(serviceType: Service.Type) -> Service {
        dependenciesFactory["\(serviceType)"]?() as! Service
    }
    
}
