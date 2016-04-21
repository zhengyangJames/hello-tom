//
//  COIconLeftButton.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 1/4/16.
//  Copyright © 2016 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

class COIconLeftButton: BaseButton {

    var icon: UIImage? {
        didSet {
            if let myIcon = icon {
                iconLeft?.image = myIcon
            }
        }
    }
    
    var titleButton: String? {
        didSet {
            if let mytitle = titleButton {
                title?.text = mytitle
            }
        }
    }
    
    private var iconLeft: UIImageView?
    private var title: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle("", forState: UIControlState.Normal)
        self.backgroundColor = AppDefine.AppColor.CORedColor
        
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self)
        contentView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self)
        
        let iconLeft_ = UIImageView()
        contentView.addSubview(iconLeft_)
        iconLeft_.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: contentView)
        iconLeft_.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 0)
        iconLeft_.autoSetDimension(ALDimension.Height, toSize: 18*AppDefine.ScreenSize.ScreenScale)
        iconLeft_.autoSetDimension(ALDimension.Width, toSize: 18*AppDefine.ScreenSize.ScreenScale)
        iconLeft = iconLeft_
        
        let titleLabel_ = UILabel()
        titleLabel_.textColor = AppDefine.AppColor.COWhiteColor
        titleLabel_.font = UIFont(name: AppDefine.AppFontName.COAvenirRoman, size: 15*AppDefine.ScreenSize.ScreenScale)
        contentView.addSubview(titleLabel_)
        titleLabel_.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: contentView)
        titleLabel_.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 0)
        titleLabel_.autoPinEdge(ALEdge.Leading, toEdge: ALEdge.Trailing, ofView: iconLeft_, withOffset: 8*AppDefine.ScreenSize.ScreenScale)
        title = titleLabel_
    }
}
