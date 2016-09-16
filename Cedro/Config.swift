//
//  Config.swift
//  Cedro
//
//  Created by Matheus Alves on 10/09/16.
//  Copyright © 2016 Zinsoft. All rights reserved.
//

import Foundation
import UIKit

struct Config {
    static var wsUrl = "http://sslapidev.mypush.com.br/world/countries/"
    static var defaultColor = Config.UIColorFromRGB(0x0080FF)
    
    static func setStatusBarColor(view:UIView, newView:UIView){
        newView.backgroundColor = self.defaultColor
        view.addSubview(newView)
    }
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}