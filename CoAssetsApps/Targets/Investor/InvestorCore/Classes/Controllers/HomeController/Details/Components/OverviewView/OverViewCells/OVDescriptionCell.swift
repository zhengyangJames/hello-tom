//
//  OVDescriptionCell.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/9/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class OVDescriptionCell: UITableViewCell {
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
}
