//
//  LinkerManager.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/16/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class FlowManager {

    static var shared = FlowManager()

    weak var menu: MenuController?
    weak var home: HomeController?
    
    var userInfoTemp = [NSObject : AnyObject]()
    
    lazy var bannerView: CONotificationBannerView = {
       let view = CONotificationBannerView()
        return view
    }()
    
    lazy var userService = {
        return UserService()
    }()
    
    lazy var profileService = {
        return ProfileService()
    }()
}
