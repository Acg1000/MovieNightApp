//
//  ImageDownloader.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/16/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
import Foundation
import UIKit


class ArtworkDownloader: Operation {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        let urlString = "https://image.tmdb.org/t/p/w92\(movie.posterPath)"
        print("Getting: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        print(imageData)
        
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {
            print("SUCCESS!")
            movie.artwork = UIImage(data: imageData)
            movie.artworkState = .downloaded
        } else {
            print("FAIL! :(")
            movie.artworkState = .failed
        }
    }
}
