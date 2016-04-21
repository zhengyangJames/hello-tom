//
//  COUserProfileModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 08/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COUserProfileModel: NSObject {
    var email = ""
    var lastName = ""
    var tokens: COUserProfileTokensModel?
    var firstName = ""
    var userName = ""
    var userProfileId = 0
    var account: COUserProfileAccountModel?
    var profile: COUserProfileDetailModel?
}

//MARK: - ImportData
extension COUserProfileModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.UserProfileField.Email].string {
            self.email = temp
        }
        if let temp = jsonData[ServiceDefine.UserProfileField.LastName].string {
            self.lastName = temp
        }
        if let _ = jsonData[ServiceDefine.UserProfileField.Tokens].dictionary {
            let tokenObject = COUserProfileTokensModel()
            tokenObject.importJsonData(jsonData[ServiceDefine.UserProfileField.Tokens])
            self.tokens = tokenObject
        }
        if let temp = jsonData[ServiceDefine.UserProfileField.FirstName].string {
            self.firstName = temp
        }
        if let temp = jsonData[ServiceDefine.UserProfileField.UserName].string {
            self.userName = temp
        }
        if jsonData[ServiceDefine.UserProfileField.UserProfileId].isExists() {
            self.userProfileId = jsonData[ServiceDefine.UserProfileField.UserProfileId].intValue
        }
        if let _ = jsonData[ServiceDefine.UserProfileField.Account].dictionary {
            let accountObject = COUserProfileAccountModel()
            accountObject.importJsonData(jsonData[ServiceDefine.UserProfileField.Account])
            self.account = accountObject
        }
        if let _ = jsonData[ServiceDefine.UserProfileField.Profile].dictionary {
            let profileObject = COUserProfileDetailModel()
            profileObject.importJsonData(jsonData[ServiceDefine.UserProfileField.Profile])
            self.profile = profileObject
        }
    }
}
