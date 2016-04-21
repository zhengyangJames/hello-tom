//
//  BaseViewController.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

class BaseViewController: UIViewController {
    private weak var customBackButton: UIButton?
    
    var isHideNavigationBar: Bool? {
        if let myNavigation = self.navigationController {
            return myNavigation.navigationBarHidden
        }
        return nil
    }
    
    lazy var backButton: UIBarButtonItem = {
        let back  = UIBarButtonItem(image: UIImage(named: "icon_back"), style: UIBarButtonItemStyle.Plain, target: self, action: "actionBack:")
        return back
    }()
    
    deinit {
        kNotification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        updateAllConstraintsWithRatio(AppDefine.ScreenSize.ScreenScale)
        if self.navigationController?.viewControllers.count >= 2 && isHideNavigationBar == false {
            if self.navigationItem.leftBarButtonItem == nil {
                self.navigationItem.leftBarButtonItem = backButton
            }
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
}

//MARK: navigationbar
extension BaseViewController {
    func hiddenNavigationBar() {
        if self.isHideNavigationBar == false {
            self.navigationController!.navigationBarHidden = true
        }
    }
    
    func showNavigationBar() {
        if self.isHideNavigationBar == true {
            self.navigationController!.navigationBarHidden = false
        }
    }
    
    func showCustomBackButton() {
        if self.customBackButton == nil {
            let button = UIButton.newAutoLayoutView()
            button.setTitle("", forState: UIControlState.Normal)
            button.setImage(UIImage(named: "icon_back"), forState: UIControlState.Normal)
            button.addTarget(self, action: "backVC", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            button.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 20)
            button.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 8)
            button.autoSetDimensionsToSize(CGSize(width: 46, height: 54))
            self.customBackButton = button
        }
        self.customBackButton?.hidden = false
        self.view.bringSubviewToFront(self.customBackButton!)
    }
    
    func hiddenCustomBackButton() {
        if self.customBackButton != nil {
            self.customBackButton?.hidden = true
            self.view.sendSubviewToBack(self.customBackButton!)
        }
    }
    
    func backVC() {
        self.popViewController()
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
        if let _ = isHideNavigationBar {
            if isHideNavigationBar! {
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
                self.navigationController?.pushViewController(viewController, animated: !animated)
            } else {
                self.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func popViewController(animated: Bool = true) {
        if let _ = isHideNavigationBar {
            if isHideNavigationBar! {
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
                self.navigationController?.popViewControllerAnimated(!animated)
            } else {
                self.navigationController?.popViewControllerAnimated(animated)
            }
        }
    }
    
    func popToRootViewController(animated: Bool = true) {
        if let _ = isHideNavigationBar {
            if isHideNavigationBar! {
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
                self.navigationController?.popToRootViewControllerAnimated(!animated)
            } else {
                self.navigationController?.popToRootViewControllerAnimated(animated)
            }
        }
    }
    
    func presentViewController(viewIsPresent: BaseViewController) {
        let rootNAV = BaseNavigationController(rootViewController: self)
        rootNAV.navigationBarHidden = true
        viewIsPresent.presentViewController(rootNAV, animated: true, completion: nil)
    }
}

//MARK: - Update constraint
extension BaseViewController {
    func updateAllConstraintsWithRatio(ratio: CGFloat) {
        for constraint in self.view.constraints {
            if constraint.isKindOfClass(COLayoutConstraint) {
                constraint.constant = constraint.constant * ratio
            }
        }
        self.updateAllConstraintsWithRatio(ratio, forView: self.view)
    }
    
    func updateAllConstraintsWithRatio(ratio: CGFloat, forView view: UIView) {
        for subview in view.subviews {
            for constraint in subview.constraints {
                if constraint.isKindOfClass(COLayoutConstraint) {
                    constraint.constant = constraint.constant * ratio
                }
            }
            self.updateAllConstraintsWithRatio(ratio, forView: subview)
        }
    }
}
