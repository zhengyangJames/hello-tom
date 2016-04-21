//
//  COScrollView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COScrollView: BaseScrollView {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
