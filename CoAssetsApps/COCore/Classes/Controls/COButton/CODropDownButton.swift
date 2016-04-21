//
//  CODropDownButton.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 18/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import PureLayout

class CODropDownButton: BaseButton {
    var title: String? {
        didSet {
            if let myTitle = title {
                self.setTitle(myTitle, forState: .Normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRectForContentRect(contentRect)
        imageFrame.size.width = 15
        imageFrame.size.height = 15
        imageFrame.origin.y = (self.frame.size.height - imageFrame.size.height)/2
        imageFrame.origin.x = (self.frame.size.width - imageFrame.size.width - 4)
        return imageFrame
    }
    
}

extension CODropDownButton {
    private func setupUI() {
        self.setTitle("", forState: UIControlState.Normal)
        self.setImage(UIImage(named: "Arror"), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
    }
}
