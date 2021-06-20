//
//  RemoteDataSource.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

protocol RemoteDataSourceProtocol {
    
    func fetchData(url: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}

class RemoteDataSource: RemoteDataSourceProtocol {
    
    
    func fetchData(url: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let safeUrl = URL(string: url) else { return }
        
        let urlRequest = URLRequest(url: safeUrl)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            guard error == nil, let data = data else {
                completionHandler(.failure(CustomError.genericError(errorMessage: "There's something went wrong please try again!")))
                return
            }
            
            guard let decodedData = self.parse(data: data) else {
                
                completionHandler(.failure(CustomError.parsingError("Can't parse this data!")))
                return
            }
            
            completionHandler(.success(decodedData))
            
        }.resume()
    }
    
    func parse(data: Data) -> [Movie]? {
        
        try? JSONDecoder().decode([Movie].self, from: data)
    }
    
}


enum CustomError: Error {
    
    case genericError(errorMessage: String)
    case parsingError(String)
}
