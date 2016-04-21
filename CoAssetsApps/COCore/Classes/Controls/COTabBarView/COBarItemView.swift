//
//  COBarItem.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

@objc protocol COBarItemViewDelegate {
    func barItemView(barItemView: COBarItemView, didSelect: Bool)
}

class COBarItemView: UIView {
    
    var backgroundNormalColor: UIColor = UIColor.whiteColor()
    var backgroundSelectedColor: UIColor = UIColor.lightGrayColor()
    var textNormalColor: UIColor = UIColor.blackColor()
    var textSelectedColor: UIColor = UIColor.whiteColor()
    
    weak var leftSeperatorView: UIView?
    weak var rightSeperatorView: UIView?
    weak var titleLabel: UILabel?
    weak var delegate: COBarItemViewDelegate!
    
    var selected: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private var didSetupUI: Bool = false
    
    var item: COBarItem? {
        didSet {
            titleLabel?.text = item?.title
        }
    }
    
    var index: Int?
    
    convenience init(item: COBarItem, index: Int, selected: Bool = false) {
        self.init()
        self.item = item
        self.index = index
        self.selected = selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetupUI {
            setupUI()
            didSetupUI = true
        }
    }
    
    private func updateUI() {
        if selected {
            self.backgroundColor = backgroundSelectedColor
            self.titleLabel?.textColor = textSelectedColor
        } else {
            self.backgroundColor = backgroundNormalColor
            self.titleLabel?.textColor = textNormalColor
        }
        leftSeperatorView?.hidden = selected
        rightSeperatorView?.hidden = selected
    }
    
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = item?.title
        titleLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirRoman, size: 12.51*AppDefine.ScreenSize.ScreenScale)
        self.addSubview(titleLabel)
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        self.addConstraints([centerX, centerY])
        self.titleLabel = titleLabel
    }
    
    private func setupUI() {
        setupTitleLabel()
        updateUI()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("actionTap:"))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func actionTap(sender: UITapGestureRecognizer) {
        delegate.barItemView(self, didSelect: true)
    }
}
