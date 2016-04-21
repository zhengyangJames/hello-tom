//
//  COUserProfileDetailModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 08/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COUserProfileDetailModel: NSObject {
    var postalCode: String?
    var countryPrefix = ""
    var regionState: String?
    var country: String?
    var city: String?
    var userProfileDetailId = 0
    var address1: String?
    var address2: String?
    var cellphone = ""
}

//MARK: - ImportData
extension COUserProfileDetailModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.PostalCode].string {
            self.postalCode = temp
        }
        
        if jsonData[ServiceDefine.UserProfileDetailField.CountryPrefix].isExists() {
            self.countryPrefix = jsonData[ServiceDefine.UserProfileDetailField.CountryPrefix].string!
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.RegionState].string {
            self.regionState = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.Country].string {
            self.country = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.City].string {
            self.city = temp
        }
        
        if jsonData[ServiceDefine.UserProfileDetailField.ProfileDetailId].isExists() {
            self.userProfileDetailId = jsonData[ServiceDefine.UserProfileDetailField.ProfileDetailId].intValue
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.Address1].string {
            self.address1 = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileDetailField.Address2].string {
            self.address2 = temp
        }
        
        if jsonData[ServiceDefine.UserProfileDetailField.CellPhone].isExists() {
            self.cellphone = jsonData[ServiceDefine.UserProfileDetailField.CellPhone].string!
        }
    }
}
