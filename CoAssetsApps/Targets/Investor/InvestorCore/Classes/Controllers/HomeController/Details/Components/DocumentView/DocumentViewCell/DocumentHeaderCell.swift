//
//  DocumentHeaderCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class DocumentHeaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: BaseLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
}
