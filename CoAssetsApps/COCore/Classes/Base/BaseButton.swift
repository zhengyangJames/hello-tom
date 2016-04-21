//
//  BaseButton.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }
    
    func viewDidLoad() {
       
    }
    
    func updateFontSize() {
        let font = self.titleLabel?.font
        if let myFont = font {
            self.titleLabel?.font = myFont.fontWithSize(myFont.pointSize * AppDefine.ScreenSize.ScreenScale)
        }
    }
}
