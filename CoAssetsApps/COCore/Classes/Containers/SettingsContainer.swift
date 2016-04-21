//
//  SettingsContainer.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class SettingsContainer: NSObject {
    
    static let userDefault = NSUserDefaults.standardUserDefaults()
    
    static var accessToken: String? {
        set {
            if let myValue = newValue {
                userDefault.setObject(myValue, forKey: AppDefine.UserDefaultKey.COAccessToken)
            } else {
                userDefault.removeObjectForKey(AppDefine.UserDefaultKey.COAccessToken)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.stringForKey(AppDefine.UserDefaultKey.COAccessToken)
        }
    }
    
    static var tokenType: String? {
        set {
            if let myValue = newValue {
                userDefault.setObject(myValue, forKey: AppDefine.UserDefaultKey.COTypeToken)
            } else {
                userDefault.removeObjectForKey(AppDefine.UserDefaultKey.COTypeToken)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.stringForKey(AppDefine.UserDefaultKey.COTypeToken)
        }
    }
    
    static var refreshToken: String? {
        set {
            if let myValue = newValue {
                userDefault.setObject(myValue, forKey: AppDefine.UserDefaultKey.CORefreshToken)
            } else {
                userDefault.removeObjectForKey(AppDefine.UserDefaultKey.CORefreshToken)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.stringForKey(AppDefine.UserDefaultKey.CORefreshToken)
        }
    }
    
    static var deviceToken: String? {
        set {
            if let myValue = newValue {
                userDefault.setObject(myValue, forKey: AppDefine.UserDefaultKey.CODeviceToken)
            } else {
                userDefault.removeObjectForKey(AppDefine.UserDefaultKey.CODeviceToken)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.stringForKey(AppDefine.UserDefaultKey.CODeviceToken)
        }
    }
    
    static var sentDeviceToken: Bool {
        set {
            userDefault.removeObjectForKey(AppDefine.UserDefaultKey.COSentDeviceToken)
            userDefault.setBool(newValue, forKey: AppDefine.UserDefaultKey.COSentDeviceToken)
            userDefault.synchronize()
        }
        get {
            return userDefault.boolForKey(AppDefine.UserDefaultKey.COSentDeviceToken)
        }
    }
    
}
