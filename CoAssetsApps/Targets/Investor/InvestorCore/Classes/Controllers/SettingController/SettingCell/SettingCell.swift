//
//  SettingCell.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/3/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class SettingCell: BaseTableViewCell {

    @IBOutlet weak private var labelContent: UILabel!
    
    var title: String? {
        didSet {
            if let myTitle = title {
                labelContent.text = myTitle
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelContent.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 17)
        separatorFullWidth()
    }
}
