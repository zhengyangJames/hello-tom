//
//  ExSlideMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/11/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController: SlideMenuController {
    
    var lockSwipe: Bool = false
    
    override func isTagetViewController() -> Bool {
        return !self.lockSwipe
    }
}
