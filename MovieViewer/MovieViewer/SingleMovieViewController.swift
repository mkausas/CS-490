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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    var movie: NSDictionary?
    
    
    override func viewDidLoad() {
        print("loaded new stuff")
        
        self.tabBarController?.tabBar.hidden = true

        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.height/2)
        
        if let movie = movie {
            let title = movie["title"] as! String
            let overview = movie["overview"] as! String
            let lang = movie["original_language"] as! String
            let rating = movie["vote_average"] as! CGFloat
            
            
            if let posterPath = movie["poster_path"] as? String {
                let baseUrl = "http://image.tmdb.org/t/p/w500"
                let smallImageUrl = "https://image.tmdb.org/t/p/w45\(posterPath)"
                let largeImageUrl = baseUrl + posterPath
//                posterView.setImageWithURL(imageUrl!)
                
                let smallImageRequest = NSURLRequest(URL: NSURL(string: smallImageUrl)!)
                let largeImageRequest = NSURLRequest(URL: NSURL(string: largeImageUrl)!)
                
                posterView.setImageWithURLRequest(
                    smallImageRequest,
                    placeholderImage: nil,
                    success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                        
                        // smallImageResponse will be nil if the smallImage is already available
                        // in cache (might want to do something smarter in that case).
                        self.posterView.alpha = 0.0
                        self.posterView.image = smallImage;
                        
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            
                            self.posterView.alpha = 1.0
                            
                            }, completion: { (sucess) -> Void in
                                
                                // The AFNetworking ImageView Category only allows one request to be sent at a time
                                // per ImageView. This code must be in the completion block.
                                self.posterView.setImageWithURLRequest(
                                    largeImageRequest,
                                    placeholderImage: smallImage,
                                    success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                        
                                        self.posterView.image = largeImage;
                                        
                                    },
                                    failure: { (request, response, error) -> Void in
                                        // do something for the failure condition of the large image request
                                        // possibly setting the ImageView's image to a default image
                                })
                        })
                    },
                    failure: { (request, response, error) -> Void in
                        // do something for the failure condition
                        // possibly try to get the large image
                })
            }
            
            let multiplier = CGFloat(1 / 10.0)
            var red: CGFloat = multiplier
            if (rating >= 0.5) {
                red *= (10 - rating)
            } else {
                red *= rating
            }

            let green: CGFloat = rating * multiplier / 1.5
            
            let ratingColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
            ratingLabel.backgroundColor = ratingColor
            ratingLabel.layer.cornerRadius = 5
            ratingLabel.clipsToBounds = true
            
            titleLabel.text = title
            descriptionLabel.text = overview
            descriptionLabel.sizeToFit()
            langLabel.text = "Lang: \(lang)"
            ratingLabel.text = "Rating: \(rating * 10)%"
            
            descriptionLabel.sizeToFit()
            infoView.sizeToFit()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
