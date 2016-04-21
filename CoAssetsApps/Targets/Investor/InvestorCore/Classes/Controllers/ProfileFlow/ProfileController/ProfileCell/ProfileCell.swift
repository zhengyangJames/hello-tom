//
//  ProfileCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ProfileCell: BaseTableViewCell {

    @IBOutlet weak private var lblTitle: BaseLabel!
    
    var stringTitle: String? {
        didSet {
            if oldValue != self.stringTitle {
                self.lblTitle.text = self.stringTitle
            }
        }
    }
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorFullWidth()
    }
    
}
