//
//  RedView.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class RedView: BaseView {
    override var backgroundColor: UIColor? {
        didSet {
             super.backgroundColor = AppDefine.AppColor.CORedColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColor = AppDefine.AppColor.CORedColor
    }
}
