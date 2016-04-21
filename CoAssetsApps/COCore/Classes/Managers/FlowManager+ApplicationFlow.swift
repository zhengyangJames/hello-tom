//
//  FlowManager+Application.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import Parse
import Crashlytics
import Fabric

extension FlowManager {
    
    //MARK: Application Lifecycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Void {
        if let notificationInfo = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject : AnyObject] {
            NotificationsManager.shared.performAppleNotificationAction(notificationInfo)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        NotificationsManager.shared.checkAndPostDeviceToken(nil)
        NotificationsManager.shared.wakeUpFromBg = false
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        NotificationsManager.shared.processAppleNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let userInfo = notification.userInfo {
             NotificationsManager.shared.processAppleNotification(userInfo)
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
        NotificationsManager.shared.receiveDeviceToken(deviceToken)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {

    }
    
    func applicationWillResignActive(application: UIApplication) {
        NotificationsManager.shared.wakeUpFromBg = true
        ConnectionManager.shared.stopTracking()
    }

}
