//
//  UIViewController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public class func vc() -> Self {
        return self.init(nibName: String(self), bundle: nil)
    }
    
    public static func vc(nibName: String) -> Self {
        return self.init(nibName: nibName, bundle: nil)
    }
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func isTopViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc == self {
                return true
            }
        }
        return false
    }
}
