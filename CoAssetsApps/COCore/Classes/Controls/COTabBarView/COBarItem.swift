//
//  COBarItem.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class COBarItem: NSObject {
    var title: String?
    var tag: Int = 0
    
    init(title: String, tag: Int = 0) {
        self.title = title
        self.tag = tag
    }
}
