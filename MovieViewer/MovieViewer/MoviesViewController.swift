//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Martynas Kausas on 1/13/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import AFNetworking
import KVNProgress
import XMSegmentedControl

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [NSDictionary]?
    var endpoint = "now_playing"
    
    @IBOutlet weak var segmentedUIView: UIView!
    @IBOutlet weak var networkErrorView: UIView!
    var filteredData: [NSDictionary]?
    
    var searchBar: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 300, 44))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        searchBar.placeholder = "Enter Title"
        searchBar.sizeToFit()
        
        self.navigationItem.titleView = searchBar
        
        let segmentedControl = XMSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), segmentTitle: ["List", "Poster"], selectedItemHighlightStyle: XMSelectedItemHighlightStyle.BottomEdge)
        
        segmentedControl.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        segmentedControl.highlightColor = UIColor(red: 255/255, green: 155/255, blue: 94/255, alpha: CGFloat(1))
        segmentedControl.tint = UIColor(white: CGFloat(17), alpha: CGFloat(1))
        segmentedControl.highlightTint = UIColor(red: 255/255, green: 155/255, blue: 94/255, alpha: CGFloat(1))
        
        segmentedUIView.addSubview(segmentedControl)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.separatorStyle = .None
        
        dispatch_async(dispatch_get_main_queue()) {
            KVNProgress.show()
        }
        retrieveMovieInfo()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        tableView.reloadData()
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
                            
                            self.networkErrorView.hidden = true
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.filteredData = self.movies
                            self.tableView.reloadData() // repopulate talble data
                            
                            KVNProgress.showSuccess()
                    }
                } else {
                    KVNProgress.showError()
                    self.networkErrorView.hidden = false
                }
        });
        task.resume()
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        retrieveMovieInfo()
        delay(0.2) { () -> () in
            self.refreshControl.endRefreshing()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredData = filteredData {
            return filteredData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as? String
        let overview = movie["overview"] as? String
        let rating = movie["vote_average"] as! CGFloat
        
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String {
            let imageUrl = NSURL(string: baseUrl + posterPath)
            
            // fade in of images
            cell.posterView.setImageWithURLRequest(
                NSURLRequest(URL: imageUrl!),
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        cell.posterView.alpha = 0.0
                        cell.posterView.image = image
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            cell.posterView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        cell.posterView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        // Use a red color when the user selects the cell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = backgroundView
        
        let multiplier = CGFloat(1 / 10.0)
        var red: CGFloat = multiplier
        if (rating >= 0.5) {
            red *= (10 - rating)
        } else {
            red *= rating
        }
        
        let green: CGFloat = rating * multiplier / 1.5
        
        let ratingColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
        cell.ratingLabel.backgroundColor = ratingColor
        cell.ratingLabel.layer.cornerRadius = 5
        cell.ratingLabel.clipsToBounds = true
        cell.ratingLabel.text = "\(rating * 10)%"

        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("happening")
        filteredData = searchText.isEmpty ? movies : movies!.filter({(currMovie: NSDictionary) -> Bool in
            if let title = currMovie["title"] as? String {
                return title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            }
            return false
        })
        
        tableView.reloadData()
    }

    @IBAction func refreshNetworkError(sender: AnyObject) {
        retrieveMovieInfo()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        
        // Use a red color when the user selects the cell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blueColor()
        cell.selectedBackgroundView = backgroundView
        
        let indexPath = tableView.indexPathForCell(cell)
    
        let singleMovieViewController = segue.destinationViewController as! SingleMovieViewController
        singleMovieViewController.movie = filteredData![indexPath!.row]

    }

}
