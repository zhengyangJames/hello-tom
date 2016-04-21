//
//  MoreInfoCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 15/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class MoreInfoLabel: BaseLabel {
    
}

class MoreInfoCell: UICollectionViewCell {

    @IBOutlet weak var valueLabel: MoreInfoLabel!
    @IBOutlet weak var nameLabel: MoreInfoLabel!
    
    var info: [String:String]? {
        didSet {
            reloadData()
        }
    }
    
    private func reloadData() {
        if let _ = info {
            for (key, value) in info! {
                valueLabel.text = value
                nameLabel.text = value.isEmpty ? "" : key
            }
        } else {
            valueLabel.text = ""
            nameLabel.text = ""
        }
    }
}
