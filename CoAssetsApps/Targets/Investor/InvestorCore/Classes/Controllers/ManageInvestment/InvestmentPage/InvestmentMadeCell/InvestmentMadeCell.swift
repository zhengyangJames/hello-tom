//
//  InvestmentMadeCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InvestmentMadeCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: BaseLabel!
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
    private func loadData(object: AnyObject) {
        titleLabel.text = object["title"] as? String
        if let imgName = object["icon"] as? String {
             icon.image = UIImage(named: imgName)
        }
    }
}
