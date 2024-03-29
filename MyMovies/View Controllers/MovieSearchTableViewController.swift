//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {

    //var movieRep: MovieRepresentation?
    var movieController = MovieController()
    var movie: Movie?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        movieController.searchForMovie(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        cell.textLabel?.text = movieController.searchedMovies[indexPath.row].title
        
        return cell
    }
    
    
    //MARK: - Add Movie Button
    
    @IBAction func addMovieButton(_ sender: Any) {
        
        guard let title = movie?.title else {return}
        if let movie = movie {
        movieController.updateMovie(movie: movie, title: title, hasWatched: true)
        
        } else {
        movieController.createMovie(with: title, hasWatched: true, context: CoreDataStack.share.mainContext)
        
        }
        
    }
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
}
