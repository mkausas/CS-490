//
//  SingleMovieViewController.swift
//  MovieViewer
//
//  Created by Martynas Kausas on 1/17/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import QuartzCore

class SingleMovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func viewDidLoad() {
        print("loaded new stuff")
        
        self.tabBarController?.tabBar.hidden = true

        
        if let movie = selectedMovie {
            let title = movie["title"] as! String
            let overview = movie["overview"] as! String
            let posterPath = movie["poster_path"] as! String
            let lang = movie["original_language"] as! String
            let rating = movie["vote_average"] as! CGFloat
            
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            
            let imageUrl = NSURL(string: baseUrl + posterPath)
            
            let multiplier = CGFloat(1 / 10.0)
            var red: CGFloat = multiplier
            if (rating >= 0.5) {
                red *= (10 - rating)
            } else {
                red *= rating
            }

            let green: CGFloat = rating * multiplier / 1.5
            
            print("red = \(red) green = \(green)")
            let ratingColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
            ratingLabel.backgroundColor = ratingColor
            ratingLabel.layer.cornerRadius = 5
            ratingLabel.clipsToBounds = true
            
            titleLabel.text = title
            descriptionLabel.text = overview
            descriptionLabel.sizeToFit()
            posterView.setImageWithURL(imageUrl!)
            langLabel.text = lang
            ratingLabel.text = "\(rating * 10)%"
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
