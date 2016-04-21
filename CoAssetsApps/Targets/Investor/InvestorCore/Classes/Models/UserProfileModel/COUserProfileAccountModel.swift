//
//  COUserProfileAccountModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 08/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COUserProfileAccountModel: NSObject {
    var accountExpiry = ""
    var accountType = ""
}

//MARK: - ImportData
extension COUserProfileAccountModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.UserProfileAccountField.AccountExpiry].string {
            self.accountExpiry = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileAccountField.AccountType].string {
            self.accountType = temp
        }
    }
}
