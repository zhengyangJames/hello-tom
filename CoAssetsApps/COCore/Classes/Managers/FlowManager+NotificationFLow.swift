//
//  FlowManager+Notifications.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

extension FlowManager {
    
    func openWebView(urlString url: String, title: String) {
        guard let topController = UIApplication.topViewController() else {
            return
        }
        if topController.isKindOfClass(WebViewController) {
            (topController as? WebViewController)!.webLink = url
            (topController as? WebViewController)!.loadWebView()
        } else {
            let webView = WebViewController.vc()
            webView.webLink = url
            webView.title = title
            let baseNAV = BaseNavigationController()
            baseNAV.viewControllers.append(webView)
            UIApplication.topViewController()?.presentViewController(baseNAV, animated: true, completion: { () -> Void in
                webView.loadWebView()
            })
        }
    }
    
    func openOfferDetailIfNeeded(offerId: NSInteger) {
        if let topView = UIApplication.topViewController() {
            if topView.isKindOfClass(WebViewController) {
                topView.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.menu?.openOfferDetail(offerId)
                })
            } else {
                self.menu?.openOfferDetail(offerId)
            }
        } else {
            self.menu?.openOfferDetail(offerId)
        }
    }
    
    func showNotificationView(alert: String?, message: String?, args: AnyObject?) {
        bannerView.delegate = self
        bannerView.textMessage = message
        bannerView.textMessage = alert
        bannerView.args = args
        let tag = UIApplication.sharedApplication().keyWindow?.tag
        if tag == BannerViewTag.tagView {
            bannerView.delayPerform()
        } else {
            bannerView.show(isWillShow: nil)
        }
    }
}

//MARK: CONotificationBannerViewDelegate
extension FlowManager: CONotificationBannerViewDelegate {
    
    func actionTapBannerView(notificationView: CONotificationBannerView, args: AnyObject?) {
        print(args)
        if let userInfo = args as? [NSObject: AnyObject] {
            NotificationsManager.shared.performAppleNotificationAction(userInfo)
        }
    }
}
