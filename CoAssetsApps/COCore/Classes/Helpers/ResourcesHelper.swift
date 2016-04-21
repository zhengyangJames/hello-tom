//
//  ResourcesHelper.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/25/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResourcesHelper: NSObject {
    
    static func readJSONFile(fileName: String) -> JSON? {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        if path != nil {
            let data = NSData(contentsOfFile: path!)
            if data != nil {
                return JSON(data: data!)
            }
        }
        return nil
    }
    
    static func readJSONFileReturnDictionary(fileName: String) -> Dictionary<NSObject, AnyObject>? {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        if path != nil {
            let data = NSData(contentsOfFile: path!)
            if data != nil {
                do {
                    let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    guard let json = jsonDic as? Dictionary<NSObject, AnyObject> else {
                        return nil
                    }
                    return json
                } catch { }
            }
        }
        return nil
    }
    
    static func readPlistFile(fileName: String) -> NSArray? {
        guard let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist") else {
            return nil
        }
        guard let arrayData = NSArray(contentsOfFile: filePath) else {
            return nil
        }
        return arrayData
    }
    
    static func readHTMLFile(fileName: String) -> NSString? {
        guard let fileURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "html") else {
            return nil
        }
        do {
            let string = try NSString(contentsOfURL: fileURL, encoding: NSASCIIStringEncoding)
            return string
        } catch { }
        return nil
    }
    
    static func getStringCurrencyOfferWithKey(key: String) -> String? {
        let obj: [String:String]! =  [
            "SGD": "Singapore Dollars",
            "USD" : "US Dollars",
            "GBP" : "British Pounds",
            "EUR" : "Euros",
            "JPY" : "Japanese Yen",
            "CNY" : "Chinese Yuan",
            "TWD" : "Taiwan Dollar",
            "CAD" : "Canadian Dollars",
            "HKD" : "Hongkong Dollar",
            "AUD" : "Australia Dollar",
            "MYR" : "Malaysia Ringit",
            "THB" : "Thai Baht",
            "PHP" : "Philippine Peso",
            "IDR" : "Indonesia Rupiah",
            "VND" : "Vietnamese Dong"
        ]
        return obj[key]
    }
    
    class func createImageNameWithCurrentDate() -> String {
        let dateString = DateHelper.photoDateAndTimeFormatter().stringFromDate(NSDate())
        let int = Int(arc4random_uniform(1000))
        let fileName = "IMG_" + dateString + String(format: "%03tu", int) + ".JPG"
        return fileName
    }
    
    static func publicDirectory() -> NSURL {
        let url: NSURL =  kFileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
            inDomains: NSSearchPathDomainMask.UserDomainMask).last! as NSURL
        return url
    }
    
    static func getLocalImage(localName: String) -> NSURL {
        let imageUrl = ResourcesHelper.publicDirectory().URLByAppendingPathComponent(localName)
        return imageUrl
    }
    
    class func getUrlImageFromAsset(editingInfo: [String : AnyObject]?) -> NSURL? {
        guard let info = editingInfo, url = info["UIImagePickerControllerReferenceURL"] as? NSURL else {
            return nil
        }
        let imagePath =  url.path!
        let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(imagePath)
        let stringURL = localPath.URLString.trimmingCharacters("file:/")
        return NSURL(string: "//" + stringURL)
    }
}
