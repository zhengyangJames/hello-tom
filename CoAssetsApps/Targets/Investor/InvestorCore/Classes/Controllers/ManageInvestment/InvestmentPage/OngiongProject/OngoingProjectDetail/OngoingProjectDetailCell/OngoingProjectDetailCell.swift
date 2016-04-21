//
//  OngoingProjectDetailCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 1/14/16.
//  Copyright © 2016 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class OngoingProjectDetailCell: UITableViewCell {
    
    @IBOutlet weak private var widthClientLabel: NSLayoutConstraint!
    @IBOutlet weak private var widthStatusLabel: NSLayoutConstraint!
    @IBOutlet weak private var widthIndicativeLabel: NSLayoutConstraint!
    @IBOutlet weak private var widthCommissionLabel: NSLayoutConstraint!
    @IBOutlet weak private var widthCommissionPayntLabel: NSLayoutConstraint!
    
    @IBOutlet weak private var client: BaseLabel!
    @IBOutlet weak private var statusLabel: BaseLabel!
    @IBOutlet weak private var indicativeLabel: BaseLabel!
    @IBOutlet weak private var commissionLabel: BaseLabel!
    @IBOutlet weak private var commissionPayntLabel: BaseLabel!
    
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var clientDetailDetailLabel: BaseLabel!
    @IBOutlet weak private var statusDetailLabel: BaseLabel!
    @IBOutlet weak private var indicativeDetailLabel: BaseLabel!
    @IBOutlet weak private var commissionDetailLabel: BaseLabel!
    @IBOutlet weak private var commissionPayntDetailLabel: BaseLabel!
    @IBOutlet weak private var view: UIView!
    
    
    var object: AnyObject? {
        didSet {
            if let myObject = object {
                loadData(myObject)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        view.layer.shadowOffset = CGSize(width: 1, height:1)
        view.layer.shadowColor = UIColor.lightGrayColor().CGColor
        view.layer.shadowOpacity = 80.0
    }
}

//MARK: Private
extension OngoingProjectDetailCell {
    private func loadData(clientObject: AnyObject) {
        updateLenghtTitle()
        titleLabel.text = clientObject["title"] as? String
        clientDetailDetailLabel.text = clientObject["Client"] as? String
        statusDetailLabel.text = clientObject["Status"] as? String
        indicativeDetailLabel.text = clientObject["Indicative"] as? String
        commissionDetailLabel.text = clientObject["Commission"] as? String
        commissionPayntDetailLabel.text = clientObject["CommissionPaynt"] as? String
    }
    
    private func updateLenghtTitle() {
        widthClientLabel.constant = widthLabel(client.text!, font: client.font)
        widthStatusLabel.constant = widthLabel(statusLabel.text!, font: statusLabel.font)
        widthIndicativeLabel.constant = widthLabel(indicativeLabel.text!, font: statusLabel.font)
        widthCommissionLabel.constant = widthLabel(commissionLabel.text!, font: statusLabel.font)
        widthCommissionPayntLabel.constant = widthLabel(commissionPayntLabel.text!, font: statusLabel.font)
        
    }
    
    private func widthLabel(text: String, font: UIFont) -> CGFloat {
        return (StringHelper.widthOfString(text, font: font) + 4)
    }
    
}
