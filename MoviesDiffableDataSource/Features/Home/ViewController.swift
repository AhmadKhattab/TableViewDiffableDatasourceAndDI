//
//  ViewController.swift
//  MoviesDiffableDataSource
//
//  Created by Ahmad Khattab on 20/06/2021.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var moviesTableView: UITableView!
    
    // Variables
    @Inject
    var viewModel: MoviesViewModel
    var dataSource: UITableViewDiffableDataSource<Int, Movie>?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel.fetchAllMovies()
        setupMoviesTableView()
        setupAllObservation()
    }


}

// MARK: - Setup movies table view

extension ViewController {

    func setupMoviesTableView() {
        dataSource = UITableViewDiffableDataSource<Int, Movie>(tableView: moviesTableView) { (tableView, indexPath, movie) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
            
            // Configure movies table view cell
            cell.textLabel?.text = movie.title
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        
        snapshot.appendItems([Movie](), toSection: 0)

        dataSource?.apply(snapshot)
    }
}

// MARK: - Update movies table view
extension ViewController {

    func setupAllObservation() {
        viewModel.movieListBox.bind { [weak self] (movies) in
            guard let self = self else { return }
            guard var snapshot = self.dataSource?.snapshot() else { return }
            snapshot.appendItems(movies)
            self.dataSource?.apply(snapshot)
            
        }

    }
}



