//
//  ClientInvestmentCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/23/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class ClientInvestmentCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: BaseLabel!
    
    @IBOutlet weak private var investmentLabel: BaseLabel!
    @IBOutlet weak private var potentialLabel: BaseLabel!

    var ongoingObject: AnyObject? {
        didSet {
            if let myObject = ongoingObject {
                loadData(myObject)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
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
extension ClientInvestmentCell {
    private func loadData(object: AnyObject) {
        titleLabel.text = object["title"] as? String
        if let mtTitle = object["investment"] as? String {
            investmentLabel.text = m_local_string("MESSAGE_INVESTMENT_MADE") + " " + mtTitle
        }
        
        if let mtTitle = object["potential"] as? String {
            potentialLabel.text = m_local_string("MESSAGE_POTENTIAL_COMMISSON") + " " + mtTitle
        }
    }
    
}
