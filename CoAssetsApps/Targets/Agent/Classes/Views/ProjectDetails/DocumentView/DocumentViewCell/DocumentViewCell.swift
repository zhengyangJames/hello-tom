//
//  DocumentViewCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class DocumentViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var icon: UIImageView!
    
    var obectDetail: AnyObject? {
        didSet {
            if let myTitle = self.obectDetail {
                loadData(myTitle)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: Private
extension DocumentViewCell {
    private func loadData(object: AnyObject) {
        icon.image = UIImage(named: object["icon"] as! String)
        titleLabel.text = object["content"] as? String
    }
}