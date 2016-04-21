//
//  COButtonIcon.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import PureLayout

class COButtonIconDeal: BaseButton {
    var title: String? {
        didSet {
            if let myTitle = title {
                textlabel?.text = myTitle
            }
        }
    }
    private var textlabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRectForContentRect(contentRect)
        imageFrame.size.width = 20
        imageFrame.size.height = 20
        imageFrame.origin.y = self.frame.origin.x/2 - 10
        imageFrame.origin.x = 20
        return imageFrame
    }

}



extension COButtonIconDeal {
    private func setupUI() {
        self.setTitle("", forState: UIControlState.Normal)
        self.layer.borderWidth = 1
        self.textlabel?.font = UIFont.systemFontOfSize(5 )
        self.textlabel?.text = m_local_string("TITLE_BUTTON")
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.setImage(UIImage(named: "ic_deal_get_start"), forState: UIControlState.Normal)
        self.setTitle(m_local_string("TITLE_BUTTON"), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
    }
}
