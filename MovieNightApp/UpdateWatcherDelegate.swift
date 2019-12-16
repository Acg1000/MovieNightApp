//
//  UpdateWatcherDelegate.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/16/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol UpdateWatcherDelegate {
    func update(_ watcher: Watcher, with genres: [Genre])
}
