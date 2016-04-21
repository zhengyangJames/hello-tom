//
//  DocumentHeaderCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class DocumentHeaderCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    
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
extension DocumentHeaderCell {
    private func loadData(title: String) {
        titleLabel.text = title
    }
}