//
//  COBackgroundView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class COBackgroundView: BaseView {
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            let newSize = CGSize(width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds))
            let NewImage = UIHelper.resizeImage(backgroundImage!, size: newSize)
            self.backgroundColor = UIColor(patternImage: NewImage)
        }
    }
}
