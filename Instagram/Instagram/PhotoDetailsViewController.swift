//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 1/27/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var photoURL: NSURL?
    var profileURL: NSURL?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    override func viewDidLoad() {
        print("dada")
        imageView.setImageWithURL(photoURL!)
        profileImage.setImageWithURL(profileURL!)

    }
    
    
}
