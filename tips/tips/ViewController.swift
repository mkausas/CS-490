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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
    
    }

    
    // calculate tips and total
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        
        // declare one time use variables
        let billAmount: Double
        let tip: Double
        let total: Double
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        
        // user has entered valid input
        if billField.text?.isEmpty == false {
            billAmount = Double(billField.text!)!
            tip = billAmount * tipPercentage;
            total = billAmount + tip;
        }
        
        // user has not entered input
        else {
            tip = 0
            total = 0
        }
        
        
        // assign new values to correct labels with additional formatting 
        tipLabel.text = String(format: "$%.2f", arguments: [tip])
        totalLabel.text = String(format: "$%.2f", arguments: [total])
        
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

