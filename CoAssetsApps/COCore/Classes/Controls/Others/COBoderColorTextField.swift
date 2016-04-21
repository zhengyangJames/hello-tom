//
//  COBoderColorTextField.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COBoderColorTextField: BaseTextField {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.borderStyle = UITextBorderStyle.None
        self.layer.borderColor = AppDefine.AppColor.COGrayWhiteColor.CGColor
        self.layer.borderWidth = 1.0
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var textRect = super.textRectForBounds(bounds)
        textRect.origin.x += 6
        textRect.size.width -= 6
        return textRect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        var textRect = super.editingRectForBounds(bounds)
        textRect.origin.x += 6
        textRect.size.width -= 6
        return textRect
    }
}
