//
//  UIhelpers.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/2/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIHelper: NSObject {
    
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

//MARK: - Show ActionSheet
extension UIHelper {
    static func showActionSheetWithTitle(title: String?, delegate: UIActionSheetDelegate?, cancelTitle: String?, destructTitle: String?, otherButtons: NSArray?, tag: Int, controller: UIViewController) {
        let actionSheet = UIActionSheet()
        if let title = title {
            actionSheet.title = title
        }
        actionSheet.delegate = delegate
        actionSheet.addButtonWithTitle(cancelTitle)
        actionSheet.cancelButtonIndex = 0
        if let otherButtons = otherButtons {
            for title in otherButtons {
                if let title = title as? String {
                    actionSheet.addButtonWithTitle(title)
                }
            }
        }
        actionSheet.tag = tag
        actionSheet.showInView(controller.view)
    }
}

//MARK: - Alert Helper
extension UIHelper {
    
    static func alertView(title: String?, message: String?) -> UIAlertView {
        let alert = UIAlertView(title: title, message: message, alertStyle: .Default, dismissOnTappingOutside: false)
        alert.alertContentTextColor = AppDefine.AppColor.COBlackColor
        alert.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 15.0)!
        alert.titleFont = UIFont(name: AppDefine.AppFontName.COAvenirBlack, size: 15.0)!
        alert.alertButtonBackgroundColor = AppDefine.AppColor.CORedColor
        alert.alertButtonTextColor = AppDefine.AppColor.COWhiteColor
        alert.alertBackgroundColor = AppDefine.AppColor.COWhiteColor
        return alert
    }
    
    static func showError(error: NSError?, actionButton: (() -> Void)?) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            let alertView = UIAlertView(title: m_string("APP_NAME"), message: nil, alertStyle: .Default, dismissOnTappingOutside: false)
            alertView.alertContentTextColor = AppDefine.AppColor.COBlackColor
            alertView.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 15.0)!
            alertView.titleFont = UIFont(name: AppDefine.AppFontName.COAvenirBlack, size: 15.0)!
            alertView.alertButtonBackgroundColor = AppDefine.AppColor.CORedColor
            alertView.alertButtonTextColor = AppDefine.AppColor.COWhiteColor
            alertView.alertBackgroundColor = AppDefine.AppColor.COWhiteColor
            alertView.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (UIAlertAction) -> Void in
                actionButton?()
            }
            if let _ = error {
                alertView.message?.text = error!.userInfo["message"] as? String
            } else {
                alertView.message?.text = "Unknown Error"
            }
            alertView.show()
        }
    }
    
}

//MARK: Action Sheet
extension UIHelper {
    
    class func actionSheet(title: String, message: String, viewController: UIViewController, callBack: CallBack) {
        let actionsheet = UIAlertController(title: m_local_string("APP_NAME"), message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let male = UIAlertAction(title: m_local_string("TITLE_BUTTON_MALE"), style: UIAlertActionStyle.Default) { (action) -> Void in
            callBack(content: m_local_string("TITLE_BUTTON_MALE"))
        }
        let feMale = UIAlertAction(title: m_local_string("TITLE_BUTTON_FEMALE"), style: UIAlertActionStyle.Default) { (action) -> Void in
            callBack(content: m_local_string("TITLE_BUTTON_FEMALE"))
        }
        
        let other = UIAlertAction(title: m_local_string("TITLE_BUTTON_OTHER"), style: UIAlertActionStyle.Default) { (action) -> Void in
            callBack(content: m_local_string("TITLE_BUTTON_OTHER"))
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        actionsheet.addAction(male)
        actionsheet.addAction(feMale)
        actionsheet.addAction(other)
        actionsheet.addAction(cancel)
        viewController.presentViewController(actionsheet, animated: true, completion: nil)
    }
    
}

//MARK: Loading
extension UIHelper {
    class func showLoadingInView(title: String? = m_local_string("please_wait")) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            SVProgressHUD.setDefaultMaskType(.Clear)
            SVProgressHUD.setBackgroundColor(UIColor.lightGrayColor())
            SVProgressHUD.showWithStatus(title)
        }
    }
    
    class func hideLoadingFromView() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            SVProgressHUD.dismiss()
        }
    }
}

//MARK: show Network Activity Indicator
extension UIHelper {
    class func showNetworkActivityIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    class func hideNetworkActivityIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
