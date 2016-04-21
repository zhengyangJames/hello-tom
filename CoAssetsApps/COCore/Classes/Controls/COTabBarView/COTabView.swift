//
//  COTabView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

extension COTabView {
    class func loadFromNibName(nibName: String, bundle: NSBundle? = nil) -> AnyObject {
        return UINib(nibName: nibName, bundle: bundle)
            .instantiateWithOwner(nil, options: nil)[0]
    }
}

class COTabView: BaseView {
    var barItem: COBarItem?
}
