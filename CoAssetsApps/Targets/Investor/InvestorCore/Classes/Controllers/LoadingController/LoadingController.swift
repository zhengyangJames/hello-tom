//
//  LoadingController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class LoadingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
    }
    
    func startRequest(callback: ((completed: Bool) -> Void)!) {
        
    }
}
