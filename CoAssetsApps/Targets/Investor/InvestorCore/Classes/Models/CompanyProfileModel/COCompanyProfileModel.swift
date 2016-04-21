//
//  COCompanyProfileFieldModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 09/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COCompanyProfileModel: NSObject {
    var orgName = ""
    var orgType = ""
    var heightImageProfile: CGFloat = 0
    var orgCountry = ""
    var address1 = ""
    var address2 = ""
    var logoPath = ""
    var orgCity = ""
}

//MARK: - Import Data
extension COCompanyProfileModel {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.CompanyProfileField.OrgName].isExists() {
            self.orgName = jsonData[ServiceDefine.CompanyProfileField.OrgName].stringValue
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.OrgType].string {
            self.orgType = temp
        }
        if jsonData[ServiceDefine.CompanyProfileField.HeightImageProfile].isExists() {
            self.heightImageProfile = CGFloat(jsonData[ServiceDefine.CompanyProfileField.HeightImageProfile].floatValue)
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.OrgCountry].string {
            self.orgCountry = temp
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.Address1].string {
            self.address1 = temp
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.Address2].string {
            self.address2 = temp
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.LogoUrl].string {
            self.logoPath = temp
        }
        if let temp = jsonData[ServiceDefine.CompanyProfileField.OrgCity].string {
            self.orgCity = temp
        }
    }
}
