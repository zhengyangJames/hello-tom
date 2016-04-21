//
//  BaseTableViewCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func separatorFullWidth() {
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
    }
}
