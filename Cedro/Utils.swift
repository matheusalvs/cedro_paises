//
//  Utils.swift
//  Cedro
//
//  Created by Matheus Alves on 15/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func getImageByUrl(url: String) -> String {
        let url:NSURL = NSURL(string : url)!
        let imageData:NSData = NSData.init(contentsOfURL: url)!
        let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return strBase64
    }
    
    static func getImageByBase64(strBase64: String) -> UIImage{
        let dataDecoded:NSData = NSData(base64EncodedString: strBase64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        return UIImage(data: dataDecoded)!
    }
}