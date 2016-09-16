//
//  Country.swift
//  Cedro
//
//  Created by Matheus Alves on 09/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import RealmSwift

class Country: Object {
    
    dynamic var uuid = NSUUID().UUIDString
    dynamic var id: Int = 0
    dynamic var iso: String = ""
    dynamic var shortName: String = ""
    dynamic var longName: String = ""
    dynamic var callingCode: String = ""
    dynamic var status: Int = 0
    dynamic var culture: String = ""
    dynamic var flag: String = ""
    dynamic var flVisited: Bool = false
    dynamic var visitedDate: NSDate? = NSDate()
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    static func insert(country: Country) {
        let realm = try! Realm()
        try! realm.write(){
            realm.add(country)
        }
    }
    
    static func insertList(countries: [Country]) {
        let realm = try! Realm()
        if countries.count > 0 {
            try! realm.write(){
                for country in countries {
                    realm.add(country)
                }
            }
            
        }
    }
    
    static func findAll() -> [Country] {
        let realm = try! Realm()
        return Array(realm.objects(Country).sorted("shortName"))
    }
    
    static func findAllVisited() -> [Country] {
        let realm = try! Realm()
        return Array(realm.objects(Country).filter("flVisited == true").sorted("shortName"))
    }
    
    static func update(country: Country){
        let realm = try! Realm()
        try! realm.write(){
            realm.add(country, update: true)
        }
    }

}
