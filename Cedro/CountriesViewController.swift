//
//  CountriesViewController.swift
//  Cedro
//
//  Created by Matheus Alves on 10/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var countriesCollectionView: UICollectionView!
    var countries = Country.findAll()
    
    var flag: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loading.hidden = true
        
        Config.setStatusBarColor(self.view, newView: UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)))
        
        countriesCollectionView.backgroundColor = UIColor.whiteColor()
        countriesCollectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        
        if countries.count == 0 {
            getAllCountries()
            self.countriesCollectionView.reloadData();
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.countries = Country.findAll()
        self.countriesCollectionView.reloadData();
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func getAllCountries() {
        self.loading.hidden = false
        self.loading.startAnimating()
        RestApi.sharedInstance.getAllCountries { json in
            let results = json
            
            self.countries.removeAll()
            for (index: _, subJson: JSON) in results {
                let country = Country()
                country.id = JSON["id"].intValue
                country.shortName = JSON["shortname"].stringValue
                country.longName = JSON["longname"].stringValue
                country.callingCode = JSON["callingCode"].stringValue
                country.flVisited = false
                country.visitedDate = NSDate()
                country.flag = Utils.getImageByUrl(Config.wsUrl + String(country.id) + "/flag")
                self.countries.append(country)
            }
            Country.insertList(self.countries)
            self.countries = Country.findAll()
            self.loading.hidden = true
            self.loading.stopAnimating()
        }
    }
    
}

extension CountriesViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CountryCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.label.text = countries[indexPath.row].shortName
        if (countries[indexPath.row].flag).characters.count > 0 {
            cell.imageView.image = Utils.getImageByBase64(countries[indexPath.row].flag)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            performSegueWithIdentifier("CountryDetail", sender: cell)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "CountryDetail"{
                let indexPath = self.countriesCollectionView?.indexPathForCell(sender as! UICollectionViewCell)
                let countryViewController: CountryViewController = segue.destinationViewController as!  CountryViewController
                let cell = sender as! CountryCollectionViewCell
                
                countryViewController.image = cell.imageView.image!
                
                let country = Country()
                country.uuid = self.countries[(indexPath?.row)!].uuid
                country.id = self.countries[(indexPath?.row)!].id
                country.shortName = self.countries[(indexPath?.row)!].shortName
                country.longName = self.countries[(indexPath?.row)!].longName
                country.callingCode = self.countries[(indexPath?.row)!].callingCode
                country.flVisited = self.countries[(indexPath?.row)!].flVisited
                country.visitedDate = self.countries[(indexPath?.row)!].visitedDate!
                country.flag = self.countries[(indexPath?.row)!].flag
                CountryViewController.country = country
            }
    }
    
}