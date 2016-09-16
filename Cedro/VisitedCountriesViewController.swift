//
//  VisitedCountriesViewController.swift
//  Cedro
//
//  Created by Matheus Alves on 10/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

class VisitedCountriesViewController: UIViewController {
    
    var visitedCountries = Country.findAllVisited()
    @IBOutlet weak var visitedCountriesTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        visitedCountries = Country.findAllVisited()
        visitedCountriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitedCountries.removeAll()
        visitedCountries = Country.findAllVisited()
        
        Config.setStatusBarColor(self.view, newView: UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

extension VisitedCountriesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visitedCountries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CountryTableViewCell
        cell.label.text = self.visitedCountries[indexPath.row].shortName
        if (visitedCountries[indexPath.row].flag).characters.count > 0 {
            cell.flag.image = Utils.getImageByBase64(visitedCountries[indexPath.row].flag)
        }
        return cell
    }
    
}