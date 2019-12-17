//
//  Genre.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Genre: Decodable {
    let id: Int
    let name: String
    
    init() {
        id = 0
        name = ""
    }
}

// Adding conformance to equatable

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        if lhs.name == rhs.name && lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
