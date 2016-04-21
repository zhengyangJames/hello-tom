//
//  BaseLabel.swift
//  CoAssets-Agent
//
//  Created by TruongVO07 on 12/23/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }
    
    func viewDidLoad() {
        let font = self.font
        
        if let myFont = font {
            self.font = myFont.fontWithSize(floor(myFont.pointSize * AppDefine.ScreenSize.ScreenScale))
        }
    }
    
}

class BaseLabelMargin: UILabel {
    override func drawTextInRect(rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRectWithSize(CGSizeMake(CGRectGetWidth(self.frame), CGFloat.max),
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: font],
                context: nil).size
            super.drawTextInRect(CGRectMake(0, 0, CGRectGetWidth(self.frame), ceil(labelStringSize.height)))
        } else {
            super.drawTextInRect(rect)
        }
    }
}
