//
//  COButton.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class COButton: BaseButton {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.titleLabel?.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 15)
        self.updateFontSize()
    }
    
    override func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        size.height += 20
        return size
    }
}
