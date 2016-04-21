//
//  FAQPageDropCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/24/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import Foundation

class FAQPageDropCell: UITableViewCell {
    
    @IBOutlet weak private var contentTextView: BaseTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        loadData()
    }
}

//MARK: Private
extension FAQPageDropCell {
    
    func loadData() {
        guard let htmlFinal = ResourcesHelper.readHTMLFile("FAQResource") else {
            return
        }
        do {
            let str = try NSAttributedString(data: htmlFinal.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            contentTextView.attributedText = str
        } catch {
            print(error)
        }
    }
    
}
