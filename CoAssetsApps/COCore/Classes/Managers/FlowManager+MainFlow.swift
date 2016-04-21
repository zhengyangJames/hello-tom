//
//  FlowManager+MainFlow.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

extension FlowManager {
    
    func activeMainFlow(window: UIWindow) {
        let homeController = HomeController.vc()
        let menuController = MenuController.vc()
        let nvc = BaseNavigationController(rootViewController: homeController)
        menuController.homeController = nvc
        SlideMenuOptions.leftViewWidth = 256
        SlideMenuOptions.contentViewScale = 1
        let slideMenu = ExSlideMenuController(mainViewController: nvc, leftMenuViewController: menuController)
        slideMenu.automaticallyAdjustsScrollViewInsets = true
        window.rootViewController = slideMenu
        menu = menuController
        home = homeController
        window.makeKeyAndVisible()
        COLoadingView.wakeupAndSync(showWithType: .ShowNone)
        ConnectionManager.shared.startTracking()
    }
    
    func activeGuestFlow() {
        
    }
    
    func openHomeFlow() {
        self.menu?.openHomeFlow()
    }
    
}
