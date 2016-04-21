//
//  COCheckButton.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/29/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COCheckButton: BaseButton {

    var isCheck: Bool?=false {
        didSet {
            unCheck(!isCheck!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        unCheck()
    }
    
    func unCheck(uncheck: Bool = true) {
        if uncheck == true {
            self.setBackgroundImage(nil, forState: UIControlState.Normal)
            self.layer.cornerRadius = 3
            self.layer.borderWidth = 1.5
            self.layer.borderColor = AppDefine.AppColor.COBlackColor.CGColor
        } else {
            self.setBackgroundImage(UIImage(named: "check"), forState: UIControlState.Normal)
        }
    }
}
