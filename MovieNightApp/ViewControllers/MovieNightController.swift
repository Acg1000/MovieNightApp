//
//  MovieNightViewController.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class MovieNightController: UIViewController {
    
    let movieApiClient = MovieClient()
    
    @IBOutlet weak var watcher1Button: UIButton!
    @IBOutlet weak var watcher1Check: UIImageView!
    @IBOutlet weak var watcher1StateDescription: UILabel!
    
    @IBOutlet weak var watcher2Button: UIButton!
    @IBOutlet weak var watcher2Check: UIImageView!
    @IBOutlet weak var watcher2StateDescription: UILabel!
    
    var watcher1Finished = false {
        didSet {
            refreshView()
            printGenres(watcher1Genres)
        }
    }
    var watcher2Finished = false {
        didSet {
            refreshView()
            printGenres(watcher2Genres)
        }
    }
    
    var watcher1Genres: [Genre] = []
    var watcher2Genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        refreshView()
        
        print("Watcher 1 Genres: \(watcher1Genres.compactMap { print($0.name)} )")
        print("Watcher 2 Genres: \(watcher2Genres.compactMap { print($0.name)} )")


        movieApiClient.discover(withGenres: [18], duringYear: 2019, sortedBy: .popularity) { results in
            print(results)
        }
        
        movieApiClient.getGenres() { results in
            print(results)
        }
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "viewResults" {
            if watcher1Genres.count == 0 || watcher2Genres.count == 0 {
                showAlertView(withTitle: "Selection Invalid", andBody: "Please select genres for both watchers")
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }

    // MARK: PrepareForSeque Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "watcher1" {
            let selectGenresController = segue.destination as! SelectGenresController
            
            selectGenresController.currentWatcher = .watcher1
            selectGenresController.delegate = self
//            selectGenresController.watcher2Finished = watcher2Finished
            
        } else if segue.identifier == "watcher2" {
            let selectGenresController = segue.destination as! SelectGenresController

            selectGenresController.currentWatcher = .watcher2
            selectGenresController.delegate = self
//            selectGenresController.watcher1Finished = watcher2Finished
        } else if segue.identifier == "viewResults" {
            let resultsController = segue.destination as! ResultsController
            
            resultsController.watcher1Genres = watcher1Genres
            resultsController.watcher2Genres = watcher2Genres
            
        }
    }
    
    // MARK: Button Functions
    
    @IBAction func clearPressed(_ sender: Any) {
        watcher1Genres = []
        watcher2Genres = []
        watcher1Finished = false
        watcher2Finished = false
        refreshView()
        
    }
    
    
    // MARK: Helper Functions
    
    func refreshView() {
        switch watcher1Finished {
        case true:
            watcher1Check.isHidden = false
            watcher1Button.isEnabled = false
            
        case false:
            watcher1Check.isHidden = true
            watcher1Button.isEnabled = true
        }
        
        switch watcher2Finished {
        case true:
            watcher2Check.isHidden = false
            watcher2Button.isEnabled = false

        case false:
            watcher2Check.isHidden = true
            watcher2Button.isEnabled = true

        }
        
        print("Views refreshed")
    }
    
    func printGenres(_ genres: [Genre]) {
        print("Printing...")
        for genre in genres {
            print("\(genre) = \(genre.name)")
        }
    }
    
    func showAlertView(withTitle title: String, andBody body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}


extension MovieNightController: UpdateWatcherDelegate {
    
    func update(_ watcher: Watcher, with genres: [Genre]) {
        print("delegate called in extension")
        
        switch watcher {
        case .watcher1:
            self.watcher1Genres = genres
            self.watcher1Finished = true
        case .watcher2:
            self.watcher2Genres = genres
            self.watcher2Finished = true
        default:
            return
            
        }
        
        navigationController?.popViewController(animated: true)
    }
}
