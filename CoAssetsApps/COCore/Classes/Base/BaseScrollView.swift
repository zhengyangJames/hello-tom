//
//  BaseScrollView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class BaseScrollView: TPKeyboardAvoidingScrollView {
    
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

}
