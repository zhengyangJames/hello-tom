//
//  ConnectionManager.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/19/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    class var shared: ConnectionManager {
        struct Singleton {
            static let instance = ConnectionManager()
        }
        return Singleton.instance
    }
    
    var isFirstTime: Bool = false
    
    class func networkIsAvailable() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .Unknown, .Offline: return false
        case .Online(.WWAN): return true
        case .Online(.WiFi): return true
        }
    }
    
    func startTracking() {
        kNotification.addObserver(self, selector: Selector("networkStatusChanged:"), name: reachabilityStatusChangedNotification, object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    func stopTracking() {
        kNotification.removeObserver(self, name: reachabilityStatusChangedNotification, object: nil)
    }
    
    func networkStatusChanged(notification: NSNotification) {
        if let object = notification.object, status = object as? String {
            switch status {
            case ReachabilityStatus.Unknown.description, ReachabilityStatus.Offline.description:
                offline()
                print("Not connected")
            case ReachabilityStatus.Online(.WWAN).description:
                if isFirstTime {
                    online()
                }
                print("Online (WWAN)")
            case ReachabilityStatus.Online(.WiFi).description:
                if isFirstTime {
                    online()
                }
                print("Online (WiFi)")
            default : break
                
            }
        }
    }
    
    func online() {
        COLoadingView.wakeupAndSync(showWithType: .ShowNone)
    }
    
    private func offline() {
        let windows = UIApplication.sharedApplication().windows.last
        if let subviews = windows?.subviews {
            for subview in subviews {
                if subview is COLoadingView, let loadingview = subview as? COLoadingView {
                    loadingview.dismiss({ (success, error) -> Void in
                        let alertView = UIHelper.alertView(m_local_string("APP_NAME"), message: m_local_string("MESSAGE_ERROR_NETWORK"))
                        alertView.addButtonWithAction(m_local_string("TITLE_BUTTON_OK"), handler: nil)
                        alertView.show()
                    })
                }
            }
        }
    }
    
}
