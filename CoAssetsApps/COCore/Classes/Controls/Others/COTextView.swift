//
//  COTextView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COTextView: BaseTextView {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layer.borderWidth = 1
        self.layer.borderColor = AppDefine.AppColor.COCurrentColor.CGColor
    }

}
