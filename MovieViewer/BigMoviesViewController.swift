//
//  BigMoviesViewController.swift
//  MovieViewer
//
//  Created by Martynas Kausas on 1/18/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class BigMoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [NSDictionary]?
    var endpoint = "now_playing"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        retrieveMovieInfo()
    }
    
    
    func retrieveMovieInfo() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.collectionView.reloadData() // repopulate talble data
                    }
                }
        });
        task.resume()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionMovieCell", forIndexPath: indexPath) as! CollectionMovieCell

        let movie = movies![indexPath.row]
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let imageUrl = NSURL(string: baseUrl + posterPath)

//        cell.movieView.setImageWithURL(imageUrl!)
        // fade in of images
        cell.movieView.setImageWithURLRequest(
            NSURLRequest(URL: imageUrl!),
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    print("Image was NOT cached, fade in image")
                    cell.movieView.alpha = 0.0
                    cell.movieView.image = image
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        cell.movieView.alpha = 1.0
                    })
                } else {
                    print("Image was cached so just update the image")
                    cell.movieView.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })

        
        
        return cell
    }
    


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
