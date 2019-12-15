//
//  MovieNightViewController.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/14/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class MovieNightController: UIViewController {
    
    let movieApiClient = MovieClient(APIKey: "931adb8f0fa9034f0eee754567a87c7f")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieApiClient.discover(withGenres: [18], duringYear: 2019, sortedBy: .popularity) { results in
            print(results)
        }
        
        movieApiClient.getGenres() { results in
            print(results)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
