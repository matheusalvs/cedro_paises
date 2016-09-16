//
//  CountryViewController.swift
//  Cedro
//
//  Created by Matheus Alves on 12/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

class CountryViewController: UIViewController {
    
    var image: UIImage = UIImage()
    @IBOutlet weak var flag: UIImageView!
    static var country = Country()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flag.image = image
        
        Config.setStatusBarColor(self.view, newView: UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)))
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func save(sender: AnyObject) {
        Country.update(CountryViewController.country)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CountryTableView" {
            let countryTableViewController: CountryTableViewController = segue.destinationViewController as! CountryTableViewController
            countryTableViewController.country = CountryViewController.country
        }
    }
    
}