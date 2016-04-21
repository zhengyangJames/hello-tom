//
//  NotificationItem.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/14/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class CONotificationItem: NSObject {
    
    var status = ""
    var type = ""
    var idItem: NSInteger = 0
    var url = ""
    var dateTimeCreated = ""
    var uniqueId = ""
    
    func importJsonData(jsonData: [String:JSON]) {
        if let temp = jsonData[ServiceDefine.NotificationField.Status]!.string {
            self.status = temp
        }
        if let temp = jsonData[ServiceDefine.NotificationField.Type]!.string {
            self.type = temp
        }
        if jsonData[ServiceDefine.NotificationField.IdKey]!.isExists() {
            self.idItem = jsonData[ServiceDefine.NotificationField.IdKey]!.intValue
        }
        if let temp = jsonData[ServiceDefine.NotificationField.Url]!.string {
            self.url = temp
        }
        if let temp = jsonData[ServiceDefine.NotificationField.DateTimeCreated]!.string {
            self.dateTimeCreated = temp
        }
        if let temp = jsonData[ServiceDefine.NotificationField.UniqueId]!.string {
            self.uniqueId = temp
        }
    }
    
}
