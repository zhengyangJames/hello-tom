//
//  CONotificationModel.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

enum NotificationStatus: String {
    case Read = "READ"
    case UnRead = "UNREAD"
    
    var isRead: Bool {
        switch self {
        case .Read: return true
        case .UnRead: return false
        }
    }
}

enum NotificationType: String {
    case Offer = "offer"
    case Event = "event"
    case Landingpg = "landingpg"
    case General = "other"
    case Payout = "payout"
    case Canews = "canews"
    
    var icon: String {
        switch self {
        case .Offer: return "offer"
        case .Event: return "event"
        case .Landingpg: return "landingpg"
        case .General: return "general"
        case .Payout: return "payout"
        case .Canews: return "ca_news"
        }
    }
}

class CONotificationModel: NSObject {
    var item: CONotificationItem!
    var alert = ""
    
    var hasUrl: Bool {
        return !item.url.isEmpty
    }
    
    var type: NotificationType! {
        return NotificationType(rawValue: item.type)
    }
    
    var status: NotificationStatus! {
        return NotificationStatus(rawValue: item.status)
    }
}

extension CONotificationModel {
    func importJsonData(jsonData: JSON) {
        if let dicData = jsonData[ServiceDefine.NotificationField.Data].dictionary {
            let item = CONotificationItem()
            item.importJsonData(dicData)
            self.item = item
        }
        if let temp = jsonData[ServiceDefine.NotificationField.Alert].string {
            alert = temp
        }
    }
}
