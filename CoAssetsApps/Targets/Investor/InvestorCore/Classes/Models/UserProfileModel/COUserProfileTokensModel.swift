//
//  COUserProfileTokensModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 08/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COUserProfileTokensModel: NSObject {
    var creditQty = 0
    var profileTokensId = 0
}

//MARK: - ImportData
extension COUserProfileTokensModel {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.UserProfileTokensField.CreditQty].isExists() {
            self.creditQty = jsonData[ServiceDefine.UserProfileTokensField.CreditQty].intValue
        }
        
        if jsonData[ServiceDefine.UserProfileTokensField.ProfileTokensId].isExists() {
            self.profileTokensId = jsonData[ServiceDefine.UserProfileTokensField.ProfileTokensId]
                .intValue
        }
    }
}
