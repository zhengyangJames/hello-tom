//
//  NaThaiPotentialCommissionCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/17/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class InVestmentDetailCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var detailLabel: BaseLabel!
    @IBOutlet weak private var titleWidth: NSLayoutConstraint!
    
    var object: AnyObject? {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
}

//MARK: - Private
extension InVestmentDetailCell {
    private func loadData() {
        if let myObject = object, str = myObject["title"] as? String {
            let title = str + ":"
            titleLabel.text = title
            detailLabel.text = myObject["detail"] as? String
            updateLeghtOfTitleLabel()
        }
    }
    
    private func updateLeghtOfTitleLabel() {
        if let str = titleLabel.text, font = titleLabel.font {
            let width = (StringHelper.widthOfString(str, font: font) + 4)
            titleWidth.constant = width
        }
    }
}

extension InVestmentDetailCell {
    func addShadowToCellTableView(tableview: UITableView, atIndexpath indexPath: NSIndexPath) {
        var isFirstRow: Bool?
        var islastRow: Bool?
        if indexPath.row == 0 {
            isFirstRow = false
        } else {
            isFirstRow = true
        }
        
        
        if indexPath.row == (tableview.numberOfRowsInSection(indexPath.section) - 1) {
            islastRow = true
        } else {
            islastRow = false
        }
        
        // the shadow rect determines the area in which the shadow gets drawn
        var shadowRect: CGRect = CGRectMake(0, 0, 0, 20)
        if isFirstRow == true {
            shadowRect.origin.y += 10
        } else if islastRow == true {
            shadowRect.size.height -= 10
            shadowRect = CGRectMake(0, -10, 0, 20)
        }
        
        // the mask rect ensures that the shadow doesn't bleed into other table cells
        var maskRect: CGRect = CGRectMake(-20, 0, 40, 0)
        if isFirstRow == true {
            maskRect.origin.y -= 10
            maskRect.size.height += 10
        } else if islastRow == true {
            maskRect.size.height += 10
        }
        
        // now configure the background view layer with the shadow
        let layer: CALayer = self.layer
        layer.shadowColor = UIColor.redColor().CGColor
        layer.shadowOffset = CGSizeMake(1, 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.75
        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 5.0).CGPath
        layer.masksToBounds = false
        
        // and finally add the shadow mask
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(rect: maskRect).CGPath
        layer.mask = maskLayer
        
    }
}
