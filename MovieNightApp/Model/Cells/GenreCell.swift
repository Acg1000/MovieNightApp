//
//  GenreCell.swift
//  MovieNightApp
//
//  Created by Andrew Graves on 12/15/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell {
    
    
    @IBOutlet weak var genreCheckImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    var isChecked = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    // returns true or false depending on if it toggled
    func toggleState() -> Bool {
        
        switch isChecked {
        case true:
            genreCheckImage.image = #imageLiteral(resourceName: "unchecked_mark")
            isChecked = false
            return true
            
        case false:
            genreCheckImage.image = #imageLiteral(resourceName: "checked_mark")
            isChecked = true
            return false
            
        }
    }
}
