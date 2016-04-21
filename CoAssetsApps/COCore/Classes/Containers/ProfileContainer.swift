//
//  ProfileContainer.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileContainer: NSObject {
    
    static let userDefault = NSUserDefaults.standardUserDefaults()
    
    static func clearAll() {
        storeUserProfileModel(nil)
        storeCompanyProfileModel(nil)
        storeInvestorProfileModel(nil)
    }
    
    static var userProfileModel: COUserProfileModel {
        let jsonString = userDefault.stringForKey(AppDefine.UserDefaultKey.UserProfileModel)
        if let data = jsonString?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let jsonData = JSON(data: data)
            let profile = COUserProfileModel()
            profile.importJsonData(jsonData)
            return profile
        }
        return COUserProfileModel()
    }
    
    static func storeUserProfileModel(jsonString: String?) {
        if let jsonString = jsonString {
            userDefault.setObject(jsonString, forKey: AppDefine.UserDefaultKey.UserProfileModel)
        } else {
            userDefault.removeObjectForKey(AppDefine.UserDefaultKey.UserProfileModel)
        }
        userDefault.synchronize()
    }
    
    static var companyProfileModel: COCompanyProfileModel {
        let jsonString = userDefault.stringForKey(AppDefine.UserDefaultKey.CompanyProfileModel)
        if let data = jsonString?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let jsonData = JSON(data: data)
            let profile = COCompanyProfileModel()
            profile.importJsonData(jsonData)
            return profile
        }
        return COCompanyProfileModel()
    }
    
    static func storeCompanyProfileModel(jsonString: String?) {
        if let jsonString = jsonString {
            userDefault.setObject(jsonString, forKey: AppDefine.UserDefaultKey.CompanyProfileModel)
        } else {
            userDefault.removeObjectForKey(AppDefine.UserDefaultKey.CompanyProfileModel)
        }
        userDefault.synchronize()
    }
    
    static var investorProfileModel: COInvestorProfileModel {
        let jsonString = userDefault.stringForKey(AppDefine.UserDefaultKey.InvestorProfileModel)
        if let data = jsonString?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let jsonData = JSON(data: data)
            let profile = COInvestorProfileModel()
            profile.importJsonData(jsonData)
            return profile
        }
        return COInvestorProfileModel()
    }
    
    static func storeInvestorProfileModel(jsonString: String?) {
        if let jsonString = jsonString {
            userDefault.setObject(jsonString, forKey: AppDefine.UserDefaultKey.InvestorProfileModel)
        } else {
            userDefault.removeObjectForKey(AppDefine.UserDefaultKey.InvestorProfileModel)
        }
        userDefault.synchronize()
    }
}
