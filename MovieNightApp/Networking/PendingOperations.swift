//
//  PendingOperations.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/16/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Purpose: Manage the pending operations for the image downloader

import Foundation

class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
