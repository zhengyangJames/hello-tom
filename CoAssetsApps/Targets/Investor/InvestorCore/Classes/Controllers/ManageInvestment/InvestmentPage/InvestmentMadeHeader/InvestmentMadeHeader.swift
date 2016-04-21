//
//  InvestmentMadeHeader.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InvestmentMadeHeader: BaseView {
    
    @IBOutlet weak private var firstView: UIView!
    @IBOutlet weak private var leftView: UIView!
    @IBOutlet weak private var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        leftView.layer.borderWidth = 0.3*AppDefine.ScreenSize.ScreenScale
        rightView.layer.borderWidth = 0.3*AppDefine.ScreenSize.ScreenScale
        leftView.layer.borderColor  = AppDefine.AppColor.CORedRimColor.CGColor
        rightView.layer.borderColor = AppDefine.AppColor.COGreenRimColor.CGColor
    }
}
