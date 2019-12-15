//
//  Movie.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let title: String
    let overview: String
    let releaseDate: String
    let id: Int
    let adult: Bool
    let popularity: Double
    let voteCount: Int
    
    init() {
        title = ""
        overview = ""
        releaseDate = ""
        id = 0
        adult = false
        popularity = 0.0
        voteCount = 0
    }
}
