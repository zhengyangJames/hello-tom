//
//  FlowManager+User.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

extension FlowManager {
    
    func openLoginFlow(context: UIViewController?, completion: (Bool) -> Void) {
        let loginNav = BaseNavigationController(rootViewController:LoginViewController.vc())
        loginNav.navigationBarHidden = true
        context?.presentViewController(loginNav, animated: true) { () -> Void in
            completion(false)
        }
    }
    
    func tryToLogin(username: String, password: String, completion: COCompletion?) {
        AuthManager.shared.requestAccessToken(username, password: password) { (success, error) -> Void in
            if success == true && error == nil {
                completion?(success: true, error: nil)
            } else {
                let error = NSError(domain: "COErrorDomain",
                                    code:0,
                                    userInfo: ["code":error!.code, "message": m_local_string("INVAlID_USERNAME_OR_PASSWORD")])
                completion?(success: false, error: error)
            }
        }
    }
    
    func syncUserData(completion: COCompletion?) {
        let tasks = SynchronizedArray<String>()
        tasks.completion = {() in
            completion?(success: true, error: nil)
        }
        tasks.append("Tasks1")
        tasks.append("Tasks2")
        tasks.append("Tasks3")
        tasks.append("Tasks4")
        profileService.getUserProfile { (data, error) -> Void in
            print("GetUserProfile: ---> \(data)")
            tasks.removeLast()
        }
        profileService.getInvestorProfile { (data, error) -> Void in
            print("GetInvestorProfile: ---> \(data)")
            tasks.removeLast()
        }
        profileService.getCompanyProfile { (data, error) -> Void in
            print("GetCompanyProfile: ---> \(data)")
            tasks.removeLast()
        }
        NotificationsManager.shared.checkAndPostDeviceToken { () -> Void in
            print("CheckAndPostDeviceToken: ---> \(SettingsContainer.sentDeviceToken)")
            NotificationsManager.shared.getNotifications { (success, error) -> Void in
                print("GetNotifications: ---> \(success)")
                tasks.removeLast()
            }
        }
    }
}
