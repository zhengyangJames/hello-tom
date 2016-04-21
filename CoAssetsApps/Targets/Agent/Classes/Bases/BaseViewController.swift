//
//  BaseViewController.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
class BaseViewController: UIViewController {
    
    var isHideNavigationBar:Bool {
        return self.navigationController!.navigationBarHidden
    }
    
    lazy var backButton:UIBarButtonItem = {
        let back  = UIBarButtonItem(image: UIImage(named: "icon_back"), style: UIBarButtonItemStyle.Plain, target: self, action: "actionBack:")
        return back
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        updateAllConstraintsWithRatio(AppDefine.ScreenSize.ScreenScale)
        showSearchBarButton()
        if self.navigationController?.viewControllers.count >= 2 && isHideNavigationBar == false {
            if (self.navigationItem.leftBarButtonItem == nil) {
                self.navigationItem.leftBarButtonItem = backButton
            }
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
}


//MARK: ShowButton
extension BaseViewController {
    func showSearchBarButton(show: Bool? = true) {
        if show == true {
            let search  = UIBarButtonItem(image: UIImage(named: "icon_search"), style: UIBarButtonItemStyle.Plain, target: self, action: "actionSearch:")
            self.navigationItem.rightBarButtonItem = search
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}

//MARK: ShowButton
extension BaseViewController {
    func actionBack(sender: AnyObject) {
        self.popViewController(true)
    }
    
    func actionSearch(sender: AnyObject) {
        
    }
}

extension BaseViewController {
    func pushViewController(viewController: UIViewController, animated: Bool = true) {
        if isHideNavigationBar {
            let transition = CATransition();
            transition.duration = 0.3;
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut);
            transition.type = kCATransitionFade;
            self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
            self.navigationController?.pushViewController(viewController, animated: !animated)
        } else {
            self.navigationController?.pushViewController(viewController, animated: animated);
        }
    }
    
    func popViewController(animated: Bool = true) {
        if isHideNavigationBar {
            let transition = CATransition();
            transition.duration = 0.3;
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut);
            transition.type = kCATransitionFade;
            self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
            self.navigationController?.popViewControllerAnimated(!animated)
        } else {
            self.navigationController?.popViewControllerAnimated(animated)
        }
    }
    
    func popToRootViewController(animated: Bool = true) {
        if isHideNavigationBar {
            let transition = CATransition();
            transition.duration = 0.3;
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut);
            transition.type = kCATransitionFade;
            self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
            self.navigationController?.popToRootViewControllerAnimated(!animated)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(animated)
        }
    }
}

//MARK: - Update constraint
extension BaseViewController {
    func updateAllConstraintsWithRatio(ratio: CGFloat) {
        for constraint in self.view.constraints {
            if (constraint.isKindOfClass(COLayoutConstraint)) {
                constraint.constant = constraint.constant * ratio
            }
        }
        self.updateAllConstraintsWithRatio(ratio, forView: self.view)
    }
    
    func updateAllConstraintsWithRatio(ratio: CGFloat, forView view: UIView) {
        for subview in view.subviews {
            for constraint in subview.constraints {
                if (constraint.isKindOfClass(COLayoutConstraint)) {
                    constraint.constant = constraint.constant * ratio
                }
            }
            self.updateAllConstraintsWithRatio(ratio, forView: subview)
        }
    }
}