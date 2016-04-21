//
//  AppDelegate.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Parse
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            setupUI(window)
            setup3rdSDKs()
            setupCoreData()
            setupNotification(application)
            FlowManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        if launchOptions == nil || launchOptions![UIApplicationLaunchOptionsURLKey] == nil {
            FBSDKAppLinkUtility.fetchDeferredAppLink({ (url: NSURL!, error: NSError!) -> Void in
                if url != nil {
                    UIApplication.sharedApplication().openURL(url)
                }
            })
        }
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        FlowManager.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        FlowManager.shared.applicationDidBecomeActive(application)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        FlowManager.shared.applicationWillEnterForeground(application)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        FlowManager.shared.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        FlowManager.shared.application(application, didReceiveLocalNotification: notification)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        FlowManager.shared.applicationWillResignActive(application)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        ConnectionManager.shared.isFirstTime = false
    }
}

//MARK: Setup
extension AppDelegate {
    
    private func setup3rdSDKs() {
        Fabric.with([Crashlytics.self])
        Parse.setApplicationId(ParseDefines.ParseAppID, clientKey: ParseDefines.ParseClientKey)
    }
    
    private func setupCoreData() {
        
    }
    
    private func setupNotification(application: UIApplication) {
        let userNotificationTypes: UIUserNotificationType = [.Alert, .Badge, .Sound]
        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }
    
    private func setupUI(window: UIWindow) {
        FlowManager.shared.activeMainFlow(window)
    }
}
