//
//  CompletedCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class CompletedCell: UITableViewCell {

    @IBOutlet weak private var currencyLabel: BaseLabel!
    @IBOutlet weak private var textFooterLabel: BaseLabel!
    
    var completeArray: [COPortfolioCompletedModel]? {
        didSet {
            refreshUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        textFooterLabel.text = m_local_string("portfolio_Completed")
    }
    func refreshUI() {
        if let completeArray = completeArray {
            var text: String?
            for completeItem in completeArray {
                let key = completeItem.keyComplete
                let value  = FormattedHelper.formartFoatValueWithPortfolio(completeItem.valueComplete)
                let contentString = key.stringByAppendingFormat("%@%@", "-", value)
                if let _ = text {
                    text = text!.stringByAppendingFormat("\n%@", contentString)
                } else {
                    text = contentString
                }
            }
            kMainQueue.addOperationWithBlock({ () -> Void in
                self.currencyLabel.text = text
            })
        }
    }
}
