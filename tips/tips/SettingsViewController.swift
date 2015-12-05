//
//  SettingsViewController.swift
//  tips
//
//  Created by Martynas Kausas on 12/4/15.
//  Copyright © 2015 Martynas Kausas. All rights reserved.
//

import UIKit



var selectedService: (String, [Double]) = ("taxi", [11, 13, 15])
var defaultTipPrice = 1

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var servicePicker: UIPickerView!
    @IBOutlet weak var tipTypePicker: UISegmentedControl!
    
    // http://money.cnn.com/pf/features/lists/tipping/
    var serviceNames: [String] = ["bartender", "waiter", "wine steward", "taxi", "food delivery", "barber", "hairdresser"]
    
    var serviceTips: [[Double]] = [[15, 17, 19], [18, 20, 22], [13, 15, 17], [11, 13, 15], [10, 15, 2], [15, 17.5, 20], [15, 17.5, 20]];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.servicePicker.delegate = self
        self.servicePicker.dataSource = self
        
        // add top logo
        let logoTitle = UIImage(named: "logo.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = logoTitle
        self.navigationItem.titleView = imageView
    }
    
    override func viewWillAppear(animated: Bool) {
        servicePicker.selectRow(serviceNames.count / 2, inComponent: 0, animated: false)
        tipTypePicker.selectedSegmentIndex = defaultTipPrice
    }

    func pickerView(pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int) {
        selectedService = (serviceNames[row], serviceTips[row])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeTipType(sender: AnyObject) {
        defaultTipPrice = tipTypePicker.selectedSegmentIndex
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceNames.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceNames[row]
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
