//
//  DocumentViewCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class DocumentViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var icon: UIImageView!
    
    var documentItem: COOfferDocumentItem? {
        didSet {
            loadData()
        }
    }
    
    func loadData() {
        titleLabel.text = documentItem?.title
        icon.image = UIImage(named: "icon_pdf")
    }
}
