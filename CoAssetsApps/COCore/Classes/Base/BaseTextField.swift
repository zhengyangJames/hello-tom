//
//  BaseTextField.swift
//  CoAssets-Agent
//
//  Created by TruongVO07 on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }
    
    func viewDidLoad() {
        let font = self.font
        if let myFont = font {
            self.font = myFont.fontWithSize(myFont.pointSize * AppDefine.ScreenSize.ScreenScale)
        }
    }
}
