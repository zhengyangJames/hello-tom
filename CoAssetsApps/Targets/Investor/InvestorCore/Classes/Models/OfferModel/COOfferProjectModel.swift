//
//  COOfferProjectModel.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COOfferProjectModel: NSObject {
     var address1 = ""
     var address2 = ""
     var city = ""
     var country = ""
     var developer = 0
     var idOfferModel = 0
     var name = ""
     var photo = ""
     var projectType = ""
     var stateRegion = ""
}

extension COOfferProjectModel {
    var address: String {
        return address1 + " " + city + " " + country
    }
}

extension COOfferProjectModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.ProjectObjectField.Address1].string {
            self.address1 = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.Address2].string {
            self.address2 = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.City].string {
            self.city = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.Country].string {
            self.country = temp
        }
        
        if jsonData[ServiceDefine.ProjectObjectField.Developer].isExists() {
            self.developer = jsonData[ServiceDefine.ProjectObjectField.Developer].intValue
        }
        
        if jsonData[ServiceDefine.ProjectObjectField.ProjectId].isExists() {
            self.idOfferModel = jsonData[ServiceDefine.ProjectObjectField.ProjectId].intValue
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.Name].string {
            self.name = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.Photo].string {
            self.photo = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.ProjectType].string {
            self.projectType = temp
        }
        
        if let temp = jsonData[ServiceDefine.ProjectObjectField.StateRegion].string {
            self.stateRegion = temp
        }
    }
}
