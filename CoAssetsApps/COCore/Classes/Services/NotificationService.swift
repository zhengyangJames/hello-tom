//
//  ListNotificationService.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ListNotificationService: COService {
    
    func postDeviceToken(deviceToken: String, completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostDeviceToken
        var headers = createAuthHeaders()
        headers[ServiceDefine.HeadersKey.HeadersContenType] = ServiceDefine.NotificationKey.ContentType
        var params = createParams()
        params[ServiceDefine.NotificationKey.DeviceToken] = deviceToken
        params[ServiceDefine.UserField.DeviceType] = ServiceDefine.NotificationKey.DeviceType
        params[ServiceDefine.UserField.ApplicationName] = ServiceDefine.NotificationKey.ApplicationNamePost
        params[ServiceDefine.UserField.ClientKey] = ServiceDefine.NotificationKey.ClientKey
        request(.POST, path, parameters: params, encoding: .URL, headers: headers) {(data, error) -> Void in
            if let error = error {
                completion?(success: false, error: error)
            } else {
                completion?(success: true, error: nil)
            }
        }
    }
    
    func getListNotification(completion: COServiceDataCompletion?) {
        guard let deviceToken = SettingsContainer.deviceToken else {
            completion?(data: nil, error: nil)
            return
        }
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetListNotification
        let headers = createAuthHeaders()
        var params = createParams()
        params[ServiceDefine.NotificationKey.DeviceToken] = deviceToken
        params[ServiceDefine.UserField.DeviceType] = ServiceDefine.NotificationKey.DeviceType
        params[ServiceDefine.UserField.ApplicationName] = ServiceDefine.NotificationKey.ApplicationNamePost
        request(.GET, path, parameters: params, encoding: .URL, headers: headers) {(data, error) -> Void in
            if let error = error {
                completion?(data: false, error: error)
            } else {
                if let temp = data, arrayData = temp.array {
                    var notificationDatas = [CONotificationModel]()
                    for jsonData in arrayData {
                        let notification = CONotificationModel()
                        notification.importJsonData(jsonData)
                        notificationDatas.append(notification)
                    }
                    completion?(data: notificationDatas, error: nil)
                } else {
                    completion?(data: nil, error: error)
                }
            }
        }
    }
    
    func readNotification(status: String, notifiUniqueId: String, completion: COCompletion?) {
        guard let deviceToken = SettingsContainer.deviceToken else {
            completion?(success: false, error: nil)
            return
        }
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ReadNotification
        let headers = createAuthHeaders()
        var params = createParams()
        params[ServiceDefine.NotificationKey.DeviceToken] = deviceToken
        params[ServiceDefine.UserField.DeviceType] = ServiceDefine.NotificationKey.DeviceType
        params[ServiceDefine.UserField.ApplicationName] = ServiceDefine.NotificationKey.ApplicationNamePost
        params[ServiceDefine.UserField.ClientKey] = ServiceDefine.NotificationKey.ClientKey
        params[ServiceDefine.NotificationKey.NotificationStatus] = status
        params[ServiceDefine.NotificationKey.NotificationId] = notifiUniqueId
        removeCaches()
        request(.POST, path, parameters: params, encoding: .URL, headers: headers) {(data, error) -> Void in
            if let error = error {
                completion!(success: false, error: error)
            } else {
                completion!(success: true, error: nil)
            }
        }
    }
    
}
