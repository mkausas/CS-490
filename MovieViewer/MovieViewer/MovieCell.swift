//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Martynas Kausas on 1/13/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setSelected(false, animated: true) // disable cell selection

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        
        // Configure the view for the selected state
    }

}
