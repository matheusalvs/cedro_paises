//
//  CountryTableViewController.swift
//  Cedro
//
//  Created by Matheus Alves on 12/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

class CountryTableViewController: UITableViewController {
    
    @IBOutlet weak var cellDate: UITableViewCell!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryLongNameLabel: UILabel!
    @IBOutlet weak var countryCallingCodeLabel: UILabel!
    @IBOutlet weak var visitedSwitch: UISwitch!
    @IBOutlet weak var visitedDatePicker: UIDatePicker!
    var country = Country()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryLabel.text = country.shortName
        countryLongNameLabel.text = country.longName
        countryCallingCodeLabel.text = country.callingCode
        
        let flVisited = country.flVisited
        if (flVisited){
            visitedSwitch.on = true
            cellDate.hidden = false
        } else {
            visitedSwitch.on = false
            cellDate.hidden = true
        }
        
        let date = country.visitedDate
        visitedDatePicker.date = date!
        
    }
    
    @IBAction func onChangeVisitedFlag(sender: AnyObject) {
        let flVisited = sender.on as Bool
        if (flVisited){
            cellDate.hidden = false
            country.flVisited = true
        } else {
            cellDate.hidden = true
            country.flVisited = false
        }
        CountryViewController.country = country
    }
    
    @IBAction func onChageVisitedDate(sender: AnyObject) {
        let visitedDate = sender.date as NSDate
        country.visitedDate = visitedDate
        CountryViewController.country = country
    }
}
