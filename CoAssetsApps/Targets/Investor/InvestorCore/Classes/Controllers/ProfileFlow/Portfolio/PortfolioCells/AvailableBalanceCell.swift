//
//  AvailableBalanceCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class AvailableBalanceCell: BaseTableViewCell {

    @IBOutlet weak private var contentLabel: BaseLabel!
    @IBOutlet weak private var headerLabel: BaseLabel!
    var availableBalanceArray: [COPortfolioBalanceModel]? {
        didSet {
                refreshUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.text = m_local_string("portfolio_available_balance")
    }
    func refreshUI() {
        if let availableBalanceArray = availableBalanceArray {
            var text: String?
            for balanceItem in availableBalanceArray {
                let currencyString = balanceItem.currency
                let balanceString  = FormattedHelper.formartFoatValueWithPortfolio(balanceItem.balanceAmt)
                let contentString = currencyString.stringByAppendingFormat("%@%@", "-", balanceString == "N/A" ? "0.00" : balanceString)
                if let _ = text {
                    text = text!.stringByAppendingFormat("\n%@", contentString)
                } else {
                    text = contentString
                }
            }
            self.contentLabel.text = text
            self.contentLabel.sizeToFit()
        }
    }
}
