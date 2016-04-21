//
//  COTextField.swift
//  CoAssets-Agent
//
//  Created by TruongVO07 on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

class COTextFieldBottomLine: BaseTextField {
    private weak var titleLabel: UILabel?
    private weak var lineBotom: CALayer?
    private weak var dropImageView: UIImageView?
    @IBInspectable var title: String? {
        didSet {
            if let myTitleLabel = titleLabel {
                myTitleLabel.text = title
            } else {
                self.setupTitle()
            }
        }
    }
    
    @IBInspectable var colorTitle: UIColor? {
        didSet {
            if let myTitleLabel = titleLabel {
                myTitleLabel.textColor = colorTitle
            } else {
                self.setupTitle()
            }
        }
    }
    
    var isShowDropImage: Bool? = false {
        didSet {
            if isShowDropImage == true {
                refreshDropImageVIew()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLineButom()
    }

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var textRect = super.textRectForBounds(bounds)
        textRect.origin.y += 10
        textRect.size.width += 8
        return textRect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        var textRect = super.editingRectForBounds(bounds)
        textRect.origin.y += 10
        textRect.size.width += 8
        return textRect
    }
}

extension COTextFieldBottomLine {
    private func setupUI() {
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = UIColor.whiteColor()
        self.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 12*AppDefine.ScreenSize.ScreenScale)
    }
    
    private func setupTitle() {
        if titleLabel == nil {
            let _titleLabel = BaseLabel()
            _titleLabel.translatesAutoresizingMaskIntoConstraints = false
            _titleLabel.textColor = colorTitle != nil ? colorTitle : UIColor.whiteColor()
            var fontSizeTitle:Int!
            if AppDefine.DeviceType.IsIPpad {
                fontSizeTitle = 15
            } else {
                fontSizeTitle = 12
            }
            _titleLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: CGFloat(fontSizeTitle) * AppDefine.ScreenSize.ScreenScale)
            self.addSubview(_titleLabel)
            _titleLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 4)
            _titleLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
            _titleLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
            _titleLabel.text = title
            titleLabel = _titleLabel
        }
    }
    
    private func setupLineButom() {
        if lineBotom == nil {
            let lineBotom1 = CALayer()
            lineBotom1.frame = CGRectMake(0.0, self.frame.height - 0.8, self.frame.width, 0.8)
            lineBotom1.backgroundColor = AppDefine.AppColor.COGrayWhiteColor.CGColor
            self.borderStyle = UITextBorderStyle.None
            self.layer.addSublayer(lineBotom1)
            lineBotom = lineBotom1
        }
    }
    
    private func refreshDropImageVIew() {
        if dropImageView == nil {
            let _dropImageView = UIImageView(image: UIImage(named: "ic_expand_arrow.png"))
            _dropImageView.frame = CGRectMake(0.0, self.frame.height - 8, 6, 6)
            _dropImageView.contentMode = UIViewContentMode.ScaleAspectFill
            _dropImageView.clipsToBounds = true
            self.rightViewMode = UITextFieldViewMode.Always
            self.rightView = UIView(frame:CGRectMake(0, 0, 6, self.frame.height))
            self.rightView?.addSubview(_dropImageView)
            _dropImageView.translatesAutoresizingMaskIntoConstraints = false
            _dropImageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: ALEdge.Top)
            dropImageView = _dropImageView
        }
    }
}
