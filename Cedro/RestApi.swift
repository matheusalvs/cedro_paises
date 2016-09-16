//
//  RestApi.swift
//  Cedro
//
//  Created by Matheus Alves on 10/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApi: NSObject {
    static let sharedInstance = RestApi()
    
    func getAllCountries(onCompletion: (JSON) -> Void) {
        makeHTTPGetRequest(Config.wsUrl + "active", onCompletion: {
            json, err in onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}