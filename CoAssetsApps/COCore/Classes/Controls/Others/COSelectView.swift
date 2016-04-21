//
//  COSelectView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 1/8/16.
//  Copyright © 2016 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COSelectView: UIView {
    override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        
        set(color) {
            super.backgroundColor = AppDefine.AppColor.COBlackColor
        }
    }
}
