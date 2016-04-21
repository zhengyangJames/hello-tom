//
//  PortfolioCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class PortfolioCell: UITableViewCell {

    @IBOutlet weak private var leftThumbnail: UIImageView!
    @IBOutlet weak private var leftDetailLabel: BaseLabelMargin!
    @IBOutlet weak private var leftValueLabel: BaseLabel!
    
    @IBOutlet weak private var rightThumbnail: UIImageView!
    @IBOutlet weak private var rightDetailLabel: BaseLabelMargin!
    @IBOutlet weak private var rightValueLabel: BaseLabel!
    
    var multiPortfolio: COMultiPortfolioModel? {
        didSet {
            if oldValue != multiPortfolio {
                refreshUI()
            }
        }
    }
    
    var indexpath: NSIndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftValueLabel.font = UIFont(
            name: AppDefine.AppFontName.COAvenirBlack,
            size: leftValueLabel.font.pointSize)
        rightValueLabel.font = UIFont(
            name: AppDefine.AppFontName.COAvenirBlack,
            size: rightValueLabel.font.pointSize)
    }
    
    func refreshUI() {
        if let multiPortfolio = multiPortfolio, indexpath = indexpath {
            if indexpath.row == 0 {
                refreshDataWhenIndexPathRowIs0(multiPortfolio)
            } else if indexpath.row == 1 {
                refreshDataWhenIndexPathRowIs1(multiPortfolio)
            }
        }
    }
    
    func refreshDataWhenIndexPathRowIs0(multiPortfolio: COMultiPortfolioModel) {
        leftThumbnail.image = UIImage(named: multiPortfolio.nameOngoingProjectsImage())
        leftDetailLabel.text = multiPortfolio.titleOngoingProjects()
        leftDetailLabel.sizeToFit()
        leftValueLabel.text = String(multiPortfolio.ongoingProject)
        rightThumbnail.image = UIImage(named: multiPortfolio.nameOngoingInvestmentImage())
        rightDetailLabel.text = multiPortfolio.titleOngoingInvestment()
        rightDetailLabel.sizeToFit()
        rightValueLabel.text = stringFromArray(multiPortfolio.ongoingInvestment)
        rightValueLabel.sizeToFit()
    }
    
    func refreshDataWhenIndexPathRowIs1(multiPortfolio: COMultiPortfolioModel) {
        leftThumbnail.image = UIImage(named: multiPortfolio.nameCompletedProjectsImage())
        leftDetailLabel.text = multiPortfolio.titleCompletedProjects()
        leftDetailLabel.sizeToFit()
        leftValueLabel.text = String(multiPortfolio.completeProject)
        rightThumbnail.image = UIImage(named: multiPortfolio.nameCompletedInvestmentImage())
        rightDetailLabel.text = multiPortfolio.titleCompletedInvestment()
        rightDetailLabel.sizeToFit()
        rightValueLabel.text = stringFromArray(multiPortfolio.completeInvestment)
        rightValueLabel.sizeToFit()
    }
    
    func stringFromArray(array: [COCurrencyInvestmentModel]?) -> String {
        var resultText = ""
        if let array = array {
            for i in 0..<array.count {
                let currency = array[i]
                var contentString = ""
                let string = FormattedHelper.formartFoatValueWithPortfolio(currency.amount)
                if string == "N/A" {
                    contentString = string
                } else {
                    contentString = currency.currency.stringByAppendingFormat("%@%@", "-", string)
                }
                if !resultText.isEmpty {
                    resultText = resultText.stringByAppendingFormat("\n%@", contentString)
                } else {
                    resultText = contentString
                }
            }
            return resultText
        }
        return "N/A"
    }
}
