//
//  ViewController.swift
//  tips
//
//  Created by Martynas Kausas on 12/4/15.
//  Copyright © 2015 Martynas Kausas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitTwoLabel: UILabel!
    @IBOutlet weak var splitThreeLabel: UILabel!
    @IBOutlet weak var tipperLabel: UILabel!
    @IBOutlet weak var bottomHalfView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add top logo
        let logoTitle = UIImage(named: "logo.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = logoTitle
        self.navigationItem.titleView = imageView
    
        
        let defaults = NSUserDefaults.standardUserDefaults()

        // load old cash amount from memory if it exists
        if let bill = defaults.objectForKey("bill") {
            billField.text = bill as? String
            
            tipLabel.text = defaults.objectForKey("tip") as? String
            totalLabel.text = defaults.objectForKey("total") as? String
            splitTwoLabel.text = defaults.objectForKey("splitTwo") as? String
            splitThreeLabel.text = defaults.objectForKey("splitThree") as? String
        }
        
        else {
            billField.text = "$"
            
            tipLabel.text = "$0"
            totalLabel.text = "$0"
            splitTwoLabel.text = "$0"
            splitThreeLabel.text = "$0"
        }
    }

    override func viewWillAppear(animated: Bool) {
        // reset tip percentages based on settings choice
        var tipPercentages = selectedService.1
        tipControl.removeAllSegments()
        tipControl.insertSegmentWithTitle("\(tipPercentages[2])%", atIndex: 0, animated: false)
        tipControl.insertSegmentWithTitle("\(tipPercentages[1])%", atIndex: 0, animated: false)
        tipControl.insertSegmentWithTitle("\(tipPercentages[0])%", atIndex: 0, animated: false)
        tipControl.selectedSegmentIndex = 1
        
        self.billField.center.y = self.view.center.y
        UIView.animateWithDuration(0.5, animations: {
            self.billField.center.y = 120
            
        })
        
        self.tipControl.alpha = 0
        self.bottomHalfView.alpha = 0
        UIView.animateWithDuration(1, animations: {
            self.tipControl.alpha = 1
            self.bottomHalfView.alpha = 1
        })
        
        tipperLabel.text = selectedService.0
        tipControl.selectedSegmentIndex = defaultTipPrice

        
    }
    
    override func viewDidAppear(animated: Bool) {
        billField.becomeFirstResponder()
    }
    
    
    // calculate tips and total
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = selectedService.1
        
        // declare one time use variables
        let billAmount: Double
        let tip: Double
        let total: Double
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        
        // user has entered valid input
        if billField.text?.isEmpty == false {
            billAmount = Double(billField.text!)!
            tip = billAmount * tipPercentage * 0.01;
            total = billAmount + tip;
        }
        
        // user has not entered input
        else {
            billAmount = 0
            tip = 0
            total = 0
        }
        
        // assign new values to correct labels with additional formatting 
        tipLabel.text = String(format: "$%.2f", arguments: [tip])
        totalLabel.text = String(format: "$%.2f", arguments: [total])
        splitTwoLabel.text = String(format: "$%.2f", arguments: [total / 2])
        splitThreeLabel.text = String(format: "$%.2f", arguments: [total / 3])
        
        
        // save values in case user closes app
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(String(billAmount), forKey: "bill")
        defaults.setObject(tipLabel.text, forKey: "tip")
        defaults.setObject(totalLabel.text, forKey: "total")
        defaults.setObject(splitTwoLabel.text, forKey: "splitTwo")
        defaults.setObject(splitThreeLabel.text, forKey: "splitThree")
        defaults.synchronize()
        
    }
    
    
    // remove keyboard on tap to view
    @IBAction func onTap(sender: AnyObject) {
            view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

