//
//  BaseNavigationController.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.respondsToSelector("interactivePopGestureRecognizer") {
            self.interactivePopGestureRecognizer?.delegate = self
            self.interactivePopGestureRecognizer?.enabled = false
            if let slideMenu = kAppDelegate?.window?.rootViewController as? ExSlideMenuController {
                if slideMenu.mainViewController == self {
                    slideMenu.lockSwipe = false
                }
            }
            self.delegate = self
        }
        self.navigationBar.translucent = true
        self.navigationBar.tintColor = UIColor.blackColor()
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: AppDefine.AppFontName.COAvenirRoman, size: 17.5*AppDefine.ScreenSize.ScreenScale)!]
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.respondsToSelector("interactivePopGestureRecognizer") {
            self.interactivePopGestureRecognizer?.enabled = false
        }
        if let slideMenu = kAppDelegate?.window?.rootViewController as? ExSlideMenuController {
            if slideMenu.mainViewController == self {
                slideMenu.lockSwipe = false
            }
        }
        super.pushViewController(viewController, animated:animated)
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers.first || self.viewControllers.first!.isKindOfClass(LoginViewController.classForCoder()) {
            if self.respondsToSelector("interactivePopGestureRecognizer") {
                self.interactivePopGestureRecognizer?.enabled = false
            }
            if let slideMenu = kAppDelegate?.window?.rootViewController as? ExSlideMenuController {
                if slideMenu.mainViewController == self {
                    slideMenu.lockSwipe = false
                }
            }
        } else {
            if self.respondsToSelector("interactivePopGestureRecognizer") {
                self.interactivePopGestureRecognizer?.enabled = true
            }
            if let slideMenu = kAppDelegate?.window?.rootViewController as? ExSlideMenuController {
                if slideMenu.mainViewController == self {
                    slideMenu.lockSwipe = true
                }
            }
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers.first {
            // nothing
        } else {
            
        }
    }
    
}
