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
    
    @IBOutlet weak private var contentTextView: UITextView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        loadData()
    }
}

//MARK: Private
extension FAQPageDropCell {
    func loadData() {
        let fontSize = 13.5*AppDefine.ScreenSize.ScreenScale
        let htmlFrame = "<span style=\"font-family: 'COAvenirLight'; font-size: \(fontSize)\">%@</span>"
        let def = "<p style = \"color: #757575 ;\">CoAssets is a targeted leads generation site, compara-ble to property listing portals. Such property listing por-tals do NOT sell properties. Instead, these portals allow property stakeholders (i.e. developers, agents, owners) (collectively, the OPs) to list available properties and real estate projects for interested investors to view.</p><p style = \"color: red;\">The typers of projects listed by CoAssets are</p><div>Bulk purchase - invest in multiple real estate units.</div><div> Crowdfunding - investors co-invest in units with others or peer-to-peer lending bu investors to OPs. </div><div> Pre-Sales - purchase of units before official launch. </div>"
        
        let htmlFinal = NSString(format: htmlFrame, def)
        
        do {
            let str = try NSAttributedString(data: htmlFinal.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            contentTextView.attributedText = str
        } catch {
            print(error)
        }
        
    }
    
}