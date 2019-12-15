//
//  GenreResponse.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/15/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}
