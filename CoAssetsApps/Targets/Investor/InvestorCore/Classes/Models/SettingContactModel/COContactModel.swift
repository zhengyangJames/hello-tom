//
//  COContactModel.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/14/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COContactModel: NSObject {
    var regNo = ""
    var city = ""
    var postalCode = ""
    var country = ""
    var add2 = ""
    var phoneNo = ""
    var add1 = ""
    var name = ""
}

extension COContactModel {
    func importDataJSON(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.ContactField.RegNo].string {
            self.regNo = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.City].string {
            self.city = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.PostalCode].string {
            self.postalCode = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.Country].string {
            self.country = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.Add2].string {
            self.add2 = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.PhoneNo].string {
            self.phoneNo = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.Add1].string {
            self.add1 = temp
        }
        
        if let temp = jsonData[ServiceDefine.ContactField.Name].string {
            self.name = temp
        }    
    }
}
