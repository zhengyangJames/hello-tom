//
//  InvestViewCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InvestViewCell: UITableViewCell {
    
    @IBOutlet weak private var imgIcon: UIImageView!
    @IBOutlet weak private var titleLAbel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    
    var objectInvest: AnyObject? {
        didSet {
            if let myObject = self.objectInvest {
                loadData(myObject)
            }
        }
    }
    
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

//MARK: Private

extension InvestViewCell {
    private func loadData(object: AnyObject) {
        imgIcon.image = UIImage(named: object["icon"] as! String)
        titleLAbel.text = object["title"] as? String
        detailLabel.text = object["detail"] as? String
    }
}