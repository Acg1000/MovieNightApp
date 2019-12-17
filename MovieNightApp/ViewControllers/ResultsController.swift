//
//  ResultsController.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class ResultsController: UITableViewController {

    var watcher1Genres: [Genre] = []
    var watcher2Genres: [Genre] = []
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let client = MovieClient()
    let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 138
        getMovies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        // Configure the cell...
        cell.movieTitle.text = movies[indexPath.row].title
        cell.releaseYear.text = movies[indexPath.row].releaseDate
        cell.movieImage.image = movies[indexPath.row].artwork

        if movies[indexPath.row].artworkState == .placeholder {
            downloadArtworkForMovies(movies[indexPath.row], atIndexPath: indexPath)
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 */
    
    // MARK: Helper Functions
    
    func setUpTableView(withMovies movies: [Movie]) {
        self.movies = movies
    }
    
    func prepareGenres() -> [Genre] {
        //
        let relatedGenres = watcher1Genres.filter(watcher1Genres.contains)
        return relatedGenres
    }
    
    func getMovies() {
        
        let genres = prepareGenres()
        
        var genreIDs: [Int] = []
        for genre in genres {
            genreIDs.append(genre.id)
        }
        
        client.discover(withGenres: genreIDs, duringYear: 2019, sortedBy: .popularity) { result in
            switch result {
            case .success(let movies):
                self.setUpTableView(withMovies: movies)
            case .failure(let error):
                print("Error getting genres in SelectGamesController: \(error)")

            }
        }
    }
    
    func downloadArtworkForMovies(_ movie: Movie, atIndexPath indexPath: IndexPath) {
        print("Downloading Movie Artwork... ")
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ArtworkDownloader(movie: movie)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                print("I'm finished!")
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
 
    // MARK: Button Functions
    
    @IBAction func donePressed(_ sender: Any) {
        tableView.reloadData()
        
    }
}
