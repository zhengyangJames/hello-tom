//
//  COTabbaView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/29/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

class COTabbaView: BaseView {
    
    var isSelected: Bool! = false {
        didSet {
            if self.isSelected == true {
                if self.tag == 1 {
                    self.backgroundColor = AppDefine.AppColor.CORedAlphaColor
                } else if self.tag == 2 {
                    self.backgroundColor = AppDefine.AppColor.COYellowAlphaColor
                } else if self.tag == 3 {
                    self.backgroundColor = AppDefine.AppColor.COBlueAlphaColor
                }
                self.backgroundColor = AppDefine.AppColor.COblueColor
            } else {
                 self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    var groudColor: UIColor? {
        didSet {
            if let myColor = groudColor {
                self.backgroundColor = myColor
            }
        }
    }

    var img: UIImage? {
        didSet {
            if let myImg = img {
                icon?.image = myImg
            }
        }
    }
    
    var titleString: String? {
        didSet {
            if let myTitle = titleString {
                titleLabel?.text = myTitle
            }
        }
    }
    
    private var icon: UIImageView?
    private var titleLabel: UILabel?
    private var rightView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColor = UIColor.clearColor()
        let icon_ = UIImageView()
        self.addSubview(icon_)
        icon_.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self)
        icon_.autoSetDimension(ALDimension.Width, toSize: 20*AppDefine.ScreenSize.ScreenScale)
        icon_.autoSetDimension(ALDimension.Height, toSize: 20*AppDefine.ScreenSize.ScreenScale)
        icon_.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 16*AppDefine.ScreenSize.ScreenScale)
        icon = icon_
        
        let title_ = UILabel()
        title_.font = UIFont(name: AppDefine.AppFontName.COAvenirRoman, size: 13*AppDefine.ScreenSize.ScreenScale)
        self.addSubview(title_)
        title_.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self)
        title_.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: icon_, withOffset: 8*AppDefine.ScreenSize.ScreenScale)
        titleLabel = title_
    }

}
