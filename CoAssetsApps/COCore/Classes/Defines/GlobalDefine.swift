//
//  AppDefine.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit


// MARK: Func
func m_string(key: String) -> String {
    return NSLocalizedString(key, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
}

// MARK: Global variables
let kAppDelegate    = UIApplication.sharedApplication().delegate as? AppDelegate
let kNotification   = NSNotificationCenter.defaultCenter()
let kMainQueue      = NSOperationQueue.mainQueue()
let kFileManager    = NSFileManager.defaultManager()
let kApplication    = UIApplication.sharedApplication()
