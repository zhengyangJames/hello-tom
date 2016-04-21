//
//  ManagerInvestmentCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class ManageInvestmentCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var icon: UIImageView!
    
    internal var dataCell: AnyObject? {
        didSet {
            if let myData = self.dataCell {
                loadData(myData)
            }
        }
    }
}

//MARk: Private
extension ManageInvestmentCell {
    func loadData(data: AnyObject) {
        titleLabel.text = data["title"] as? String
        detailLabel.text = data["detail"] as? String
        icon?.image = UIImage(named: (data["icon"] as? String)!)
    }
}
