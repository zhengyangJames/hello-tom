//
//  AuthManager.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class AuthManager {
    
    static let shared = AuthManager()
    
    private var notificationManager: NotificationsManager {
        return NotificationsManager.shared
    }
    
    lazy var userService = {
        return UserService()
    }()
}

// MARK: Access Token
extension AuthManager {
    
    func hasAccessToken() -> Bool {
        return SettingsContainer.accessToken?.isEmpty == false
    }
    
    func revokeAccessToken() {
        SettingsContainer.accessToken = nil
        SettingsContainer.tokenType = nil
        SettingsContainer.refreshToken = nil
        SettingsContainer.sentDeviceToken = false
        ProfileContainer.clearAll()
        kNotification.postNotificationName(AppDefine.NotificationKey.RevokedAccessToken, object: nil)
    }
    
    func requestAccessToken(username: String, password: String, completion: COCompletion?) {
        var param = [String:String]()
        param[ServiceDefine.UserField.UserName] = username
        param[ServiceDefine.UserField.Password] = password
        userService.startOAuthLogin(param) { (data, error) -> Void in
            if let error = error {
                completion?(success: false, error: error)
            } else {
                self.processOAuth2Response(data, completion: completion)
            }
        }
    }
    
    func checkPermission(context: UIViewController?, completion: (Bool) -> Void) -> Void {
        if AuthManager.shared.hasAccessToken() {
            completion(true)
        } else {
            FlowManager.shared.openLoginFlow(context, completion: completion)
        }
    }

    private func processOAuth2Response(data: JSON?, completion: COCompletion?) {
        if let myData = data, token = myData["access_token"].string, typeToken = myData["token_type"].string, refreshToken = myData["refresh_token"].string {
            SettingsContainer.accessToken = token
            SettingsContainer.tokenType = typeToken
            SettingsContainer.refreshToken = refreshToken
            kNotification.postNotificationName(AppDefine.NotificationKey.GrantedAccessToken, object: nil)
            completion?(success: true, error: nil)
        } else {
            revokeAccessToken()
            let error = NSError(domain: "COErrorDomain", code:0, userInfo: ["code":500,"message":"NO Access Token"])
            completion?(success: false, error: error)
        }
    }
}
