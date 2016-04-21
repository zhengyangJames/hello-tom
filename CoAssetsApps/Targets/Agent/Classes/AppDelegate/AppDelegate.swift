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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.checkLoginFlow()
        self.setup3rdSDKs()
        self.setupCoreData()
        self.window?.makeKeyAndVisible()
        return true
    }
}

//MARK: Private
extension AppDelegate {
    private func setup3rdSDKs() {
        Fabric.with([Crashlytics.self])
    }
    
    private func setupCoreData() {
    }
    
    private func checkLoginFlow() {
        if kUserDefault.boolForKey(AppDefine.UserDefaultKey.LoggedIn) == true {
            self.setupAfterLoginFlow()
        } else {
            self.setupLoginFlow()
        }
    }
}

//MARK: Public
extension AppDelegate {
    func setupLoginFlow() {
        let rootVC = LoginViewController(nibName:LoginViewController.className,bundle: nil)
        let rootNAV = BaseNavigationController(rootViewController: rootVC)
        rootNAV.navigationBarHidden = true
        if let myWindown = self.window {
            myWindown.rootViewController = rootNAV
        } else {
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = rootNAV
            self.window = window
        }
    }
    
    func setupAfterLoginFlow() {
        let rootVC = WelcomeViewController(nibName:WelcomeViewController.className,bundle: nil)
        let rootNAV = BaseNavigationController(rootViewController: rootVC)
        if let myWindown = self.window {
            myWindown.rootViewController = rootNAV
        } else {
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = rootNAV
            self.window = window
        }
        
    }
}

