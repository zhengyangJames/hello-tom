//
//  InvestmentMadeCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InvestmentMadeCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var icon: UIImageView!
    
    var object: AnyObject? {
        didSet {
            if let myObject = object {
                loadData(myObject)
            }
        }
    }
}

//MARK: Private
extension InvestmentMadeCell {
    private func loadData(object_: AnyObject) {
        titleLabel.text = object_["title"] as? String
        icon.image = UIImage(named: object_["icon"] as? String)
    }
}
