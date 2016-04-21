//
//  HeaderViewCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/17/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var view: UIView!
    
    var titleString: String? {
        didSet {
            if let myTitle = self.titleString {
                loadData(myTitle)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None

    }
}

//MARK: Private
extension HeaderViewCell {
    private func loadData(title: String) {
        titleLabel!.text = title
    }
}
