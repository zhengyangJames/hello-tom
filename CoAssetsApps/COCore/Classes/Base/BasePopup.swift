//
//  BasePopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

class BasePopup: BaseView {
    
    var isShowKeyboard: Bool = false
    
    override func viewDidLoad() {
        self.backgroundColor = UIColor.clearColor()
        let grayView = UIView()
        grayView.backgroundColor = AppDefine.AppColor.COBlackColor
        grayView.alpha = 0.6
        grayView.superview
        self.insertSubview(grayView, atIndex: 0)
        grayView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        let tap = UITapGestureRecognizer(target: self, action: "actionRemovePopup:")
        grayView.addGestureRecognizer(tap)
        updateAllConstraintsWithRatio(AppDefine.ScreenSize.ScreenScale)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        isShowKeyboard = true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        isShowKeyboard = false
    }
}

extension BasePopup {
    func popView() {
        if isShowKeyboard == true {
            self.endEditing(true)
        } else {
            self.removeFromSuperview()
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
}

extension BasePopup {
    func actionRemovePopup(sender: AnyObject) {
        popView()
    }
}

extension BasePopup {
    func updateAllConstraintsWithRatio(ratio: CGFloat) {
        for constraint in self.constraints {
            if constraint.isKindOfClass(COLayoutConstraint) {
                constraint.constant = constraint.constant * ratio
            }
        }
        self.updateAllConstraintsWithRatio(ratio, forView: self)
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
