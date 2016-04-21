//
//  NotificationsManager+Token.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

extension NotificationsManager {
    
    private func postDeviceToken(completion: ((Void) -> Void)?) {
        guard let deviceToken = SettingsContainer.deviceToken else {
            completion?()
            return
        }
        notificationService.postDeviceToken(deviceToken, completion: { (success, error) -> Void in
            if success {
                SettingsContainer.sentDeviceToken = true
            } else {
                SettingsContainer.sentDeviceToken = false
            }
            completion?()

        })
    }
    
    private func storeDeviceToken(tokenData: NSData) {
        let characterSet: NSCharacterSet = NSCharacterSet(charactersInString: "<>" )
        let deviceTokenString: String = ( tokenData.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        SettingsContainer.deviceToken = deviceTokenString
    }
    
    func checkAndPostDeviceToken(completion: ((Void) -> Void)?) {
        if SettingsContainer.sentDeviceToken == false && AuthManager.shared.hasAccessToken() {
            postDeviceToken(completion)
        } else {
            completion?()
        }
    }
    
    func receiveDeviceToken(tokenData: NSData) {
        storeDeviceToken(tokenData)
        checkAndPostDeviceToken(nil)
    }
}
