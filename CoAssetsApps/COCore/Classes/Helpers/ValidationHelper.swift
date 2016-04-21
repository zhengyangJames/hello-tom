//
//  ValidHelper.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ValidHelper: NSObject {
    static func isValidEmail(emailText: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(emailText)
        return result
    }
    
    static func isValidatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "\\+?[0-9]{1,13}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluateWithObject(value)
        return result
    }
    
    static func stringIsDecimalNumber(stringValue: String) -> Bool {
        let scan = NSScanner(string: stringValue)
        scan.charactersToBeSkipped = NSCharacterSet(charactersInString: "1234567890.").invertedSet
        if scan.scanDouble(nil) {
            return scan.atEnd
        } else {
            return false
        }
    }
}
