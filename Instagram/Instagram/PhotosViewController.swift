//
//  ViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 1/20/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    var content: [NSDictionary]?
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 420
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
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
                            self.content = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let content = content {
            return content.count
        } else {
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! CustomCell
        
        let imageContent = content![indexPath.row]
        let user = imageContent["user"]
        
        let userName = user!["username"] as! String
        let profileURLString = user!.valueForKey("profile_picture") as! String
        let profilePicUrl = NSURL(string: profileURLString)
        let postURLString = imageContent.valueForKey("images")?.valueForKey("standard_resolution")?.valueForKey("url") as! String
        let postPicUrl = NSURL(string: postURLString)
        let likes = imageContent.valueForKey("likes")?.valueForKey("count") as! Int
        
        
        cell.profileImage.setImageWithURL(profilePicUrl!)
        cell.profileImage.clipsToBounds = true
        cell.profileImage.layer.cornerRadius = 20;
        cell.profileImage.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        cell.profileImage.layer.borderWidth = 1;
        
        cell.postImage.setImageWithURL(postPicUrl!)
        cell.userName.text = userName
        cell.likes.text = "\(likes) likes"
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! CustomCell)
        let postInfo: NSDictionary? = content![indexPath!.row]
        
        if let postInfo = postInfo {
            let user = postInfo["user"]

            
            let userName = user!["username"] as! String
            let profileURLString = user!.valueForKey("profile_picture") as! String
            let profilePicUrl = NSURL(string: profileURLString)
            let postURLString = postInfo.valueForKey("images")?.valueForKey("standard_resolution")?.valueForKey("url") as! String
            let postPicUrl = NSURL(string: postURLString)
            let likes = postInfo.valueForKey("likes")?.valueForKey("count") as! Int
            
            NSLog("\(user)")

            vc.photoURL = postPicUrl
            vc.profileURL = profilePicUrl
            
            print(postPicUrl)
//            if let url = postPicUrl {
//                vc.imageView.setImageWithURL(url)
//            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

