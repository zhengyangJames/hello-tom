//
//  UtilsHelper.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/15/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class UtilsHelper: NSObject {

    class func createDataFromParams(parameters: Dictionary<String, AnyObject>?, key: String) -> NSData {
        if let _ = parameters {
            let data = parameters![key]!.dataUsingEncoding(NSUTF8StringEncoding)
            if let tempData = data {
                return tempData
            }
        }
        return NSData()
    }
    
    class func getUrlFromParams(parameters: Dictionary<String, AnyObject>?, key: String) -> NSURL? {
        guard let myParam = parameters, url = myParam[key] as? String else {
            return nil
        }
        return NSURL(fileURLWithPath: url)
    }
    
    class func creatDataFromValue(value: String?) -> NSData {
        if let _ = value {
            guard let data = value!.dataUsingEncoding(NSUTF8StringEncoding) else {
                return NSData()
            }
            return data
        }
        return NSData()
    }
    
}
