//
//  Movie.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Movie {
    let title: String
    let overview: String
    let release_date: String
    let id: Int
    let adult: Bool
    let popularity: Int
    let voteCount: Int
    
    init() {
        title = ""
        overview = ""
        release_date = ""
        id = 0
        adult = false
        popularity = 0
        voteCount = 0
    }
}
