//
//  NotificationsManager.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/11/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotificationsManager {
    
    static let shared = NotificationsManager()
    
    var wakeUpFromBg = false
    
    var notificationCount: NSInteger = 0 {
        didSet {
            FlowManager.shared.menu!.reloadData()
        }
    }
    
    var notificationModel = [CONotificationModel]() {
        didSet {
            var count = 0
            for item in notificationModel where item.item.status == "UNREAD" {
                count++
            }
            self.notificationCount = count
        }
    }
    
    lazy var notificationService = {
        return ListNotificationService()
    }()
}

// MARK: Update UI
extension NotificationsManager {

    func performCONotificationAction(notification: CONotificationModel, completion: COCompletion?) {
        if notification.status == .UnRead {
            let notifiUniqueId = notification.item.uniqueId
            let statusNotifi = NotificationStatus.UnRead.rawValue
            readNotification(statusNotifi, notifiUniqueId: String(notifiUniqueId), completion: completion)
        }
        if notification.hasUrl == true {
            let urlString = notification.item.url
            FlowManager.shared.openWebView(urlString: urlString, title: m_local_string("TITLE_NOTIFICATIONS"))
        } else if notification.type == .Offer {
            let offerID = notification.item.idItem
            FlowManager.shared.openOfferDetailIfNeeded(offerID)
        }
    }
    
    func performAppleNotificationAction(userInfo: [NSObject:AnyObject]) {
        guard let data = userInfo["data"] as? NSDictionary else {
            return
        }
        if let url = data["url"], urlString = url as? String where urlString.isEmpty == false {
            FlowManager.shared.openWebView(urlString: urlString, title: m_local_string("TITLE_NOTIFICATIONS"))
        } else if let type = data["type"], typeString = type as? String where typeString == "offer" {
            if let offerID = data["id"], offerIDString = offerID as? NSString {
                FlowManager.shared.openOfferDetailIfNeeded(offerIDString.integerValue)
            } else if let offerID = data["id"], offerIDNSNumber = offerID as? NSNumber {
                FlowManager.shared.openOfferDetailIfNeeded(offerIDNSNumber.integerValue)
            }
        }
    }
    
    func processAppleNotification(userInfo: [NSObject:AnyObject]) {
        if wakeUpFromBg {
            guard let apsDict = userInfo["aps"] as? NSDictionary else {
                return
            }
            performAppleNotificationAction(apsDict as [NSObject : AnyObject])
        } else {
            guard let apsDict = userInfo["aps"] as? NSDictionary else {
                return
            }
            var pushAlert: String?
            var pushMessage: String?
            if let alertDict = apsDict["alert"] as? NSDictionary, message = alertDict["message"] as? NSString {
                pushMessage = message as String
            } else if let alert = apsDict["alert"] as? NSString {
                pushAlert = alert as String
            }
            FlowManager.shared.showNotificationView(pushAlert, message: pushMessage, args: apsDict)
        }
    }
}

// MARK: Service Call
extension NotificationsManager {
    
    func getNotifications(completion: COCompletion?) {
        notificationService.getListNotification { (data, error) -> Void in
            if data != nil && error == nil {
                if let listNotificationModel = data as? [CONotificationModel] {
                    self.notificationModel = listNotificationModel
                    completion?(success: true, error: nil)
                } else {
                    completion?(success: false, error: error)
                }
            } else {
                completion?(success: false, error: error)
            }
        }
    }
    
    func readNotification(status: String, notifiUniqueId: String, completion: COCompletion?) {
        notificationService.readNotification(status, notifiUniqueId: notifiUniqueId) { (success, error) -> Void in
            if let _ = error {
                completion?(success: false, error: error)
            } else {
                self.getNotifications({ (success, error) -> Void in
                    if let _ = error {
                        completion?(success: false, error: error)
                    } else {
                        completion?(success: true, error: nil)
                    }
                })
            }
        }
    }
}
