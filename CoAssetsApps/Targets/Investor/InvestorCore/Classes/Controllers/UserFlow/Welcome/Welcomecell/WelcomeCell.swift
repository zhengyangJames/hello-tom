//
//  WelcomeCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 1/8/16.
//  Copyright © 2016 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var detailLabel: BaseLabel!
    @IBOutlet weak private var backgroundImage: UIImageView!
    @IBOutlet weak private var selectedView: COSelectView!
    @IBOutlet weak private var topContrains: NSLayoutConstraint!
    @IBOutlet weak private var bottomContrains: NSLayoutConstraint!
    @IBOutlet weak private var view: UIView!
    
    var object: AnyObject? {
        didSet {
            if let myObject = object {
                loadData(myObject)
            }
        }
    }
    
    var isFirstItemIntableView: Bool? {
        didSet {
            topContrains.constant = isFirstItemIntableView == true ? 6.0 : 3.0
        }
    }
    
    var isLastItemIntableView: Bool? {
        didSet {
            bottomContrains.constant = isLastItemIntableView == true ? 6.0 : 3.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.Default
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.layer.shadowOffset = CGSize(width: 1, height:1)
        backgroundImage.layer.shadowColor = UIColor.darkGrayColor().CGColor
        backgroundImage.layer.shadowOpacity = 80.0
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected == false {
            selectedView.alpha = 0.0
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted == true {
            selectedView.alpha = 0.2
        }
    }
}

extension WelcomeCell {
    private func loadData(data: AnyObject) {
        titleLabel.text = data["title"] as? String
        detailLabel.text = data["detail"] as? String
        if let stringImg = data["img"] as? String {
             backgroundImage.image = UIImage(named: stringImg)
        }
    }
}
