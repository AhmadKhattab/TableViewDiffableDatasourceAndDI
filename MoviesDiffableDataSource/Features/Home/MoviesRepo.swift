//
//  MoviesRepo.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

protocol MoviesRepoProtocol {
    
    var remoteDataSource: RemoteDataSourceProtocol { get set }
    func fetchAllMovies(url: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}

class MoviesRepo: MoviesRepoProtocol {
    var remoteDataSource: RemoteDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    func fetchAllMovies(url: String, completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        print("Hello from movies repo")
        remoteDataSource.fetchData(url: url, completionHandler: completionHandler)
    }
}


