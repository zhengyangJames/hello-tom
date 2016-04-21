//
//  FormattedHelper.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class FormattedHelper: NSObject {
    
    static func formartDecimalFromNSNumber(number: NSNumber) -> String? {
        let formater = NSNumberFormatter()
        formater.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let cvString = formater.stringFromNumber(number)
        return cvString
    }
    
    static func formartFoatValueWithPortfolio(value: NSNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let newString = formatter.stringFromNumber(NSNumber(float: value.floatValue))
        if newString == "0.00" {
            return "N/A"
        }
        return newString!
    }
    
    static func formartFoatValueWithDeal(value: NSNumber, min: NSInteger) -> NSString {
        let formater = NSNumberFormatter()
        formater.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formater.maximumFractionDigits = 2
        formater.minimumFractionDigits = min
        let stringNew = formater.stringFromNumber(NSNumber(float: value.floatValue))
        return NSString(format: "%@", stringNew!)
    }
    
}
