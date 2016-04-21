//
//  COBubbleLabel.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/15/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class COBubbleLabel: UILabel {

    var badgeCount: Int = 0 {
        didSet {
            if badgeCount < 0 {
                badgeCount = 0
            } else if badgeCount > 0 {
                self.hidden = false
                self.text = "\(badgeCount)"
            } else {
                self.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.redColor()
        textAlignment = NSTextAlignment.Center
        textColor = UIColor.whiteColor()
        font = UIFont.systemFontOfSize(17)
        text = "\(badgeCount)"
        layer.cornerRadius = self.frame.size.width/2
        layer.masksToBounds = true
    }
    
    override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set (color) {
            super.backgroundColor = UIColor.redColor()
        }
    }

}
