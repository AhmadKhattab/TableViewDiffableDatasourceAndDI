//
//  MoviesViewModel.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import Foundation

protocol MoviesViewModelProtocol {
    var moviesRepo: MoviesRepoProtocol { get set }
    var movieListBox: BoxModel<[Movie]> { get }
    func fetchAllMovies()
}


class MoviesViewModel: MoviesViewModelProtocol {
    
    // Variables
    var moviesRepo: MoviesRepoProtocol
    var movieListBox: BoxModel<[Movie]> = BoxModel(value: [Movie]())
   
    init(moviesRepo: MoviesRepoProtocol) {
        self.moviesRepo = moviesRepo
    }
    
    // MARK: - Access to movies model
    
    func fetchAllMovies() {
        
        moviesRepo.fetchAllMovies(url: Endpoint.moviesUrl) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure:
                print("There is something went wrong!")
            case let .success(movies):
                DispatchQueue.main.async {
                    self.movieListBox.value = movies
                }
               
            }
        }
    }
    
    // MARK: - Intent(s)
    
}

struct Endpoint {
    static let moviesBaseURL = "https://api.androidhive.info"
    static let moviesEndPoint = "/json/movies.json"
    static let moviesUrl = moviesBaseURL + moviesEndPoint
}
