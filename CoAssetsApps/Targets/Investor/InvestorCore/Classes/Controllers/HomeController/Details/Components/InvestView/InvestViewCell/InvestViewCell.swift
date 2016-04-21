//
//  InvestViewCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InvestViewCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        if self.respondsToSelector("setSeparatorInset:") {
            self.separatorInset = UIEdgeInsetsZero
        }
        if self.respondsToSelector("setLayoutMargins:") {
            self.layoutMargins = UIEdgeInsetsZero
        }
        if self.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            self.preservesSuperviewLayoutMargins = false
        }
        
    }
}
