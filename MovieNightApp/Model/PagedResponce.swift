//
//  PagedResponce.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

struct PagedResponse<T: Decodable>: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [T]
}
