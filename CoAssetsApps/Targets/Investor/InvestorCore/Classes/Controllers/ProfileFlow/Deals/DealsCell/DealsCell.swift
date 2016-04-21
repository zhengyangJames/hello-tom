//
//  DealsCell.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

typealias COCompletionDealCell = () -> Void
class DealsCell: BaseTableViewCell {
    
    @IBOutlet weak private var projectNameValueLabel: BaseLabel!
    @IBOutlet weak private var investmentAmountTitleLabel: BaseLabel!
    @IBOutlet weak private var investmentAmountValueLabel: BaseLabel!
    @IBOutlet weak private var potentialReturnsTitleLabel: BaseLabel!
    @IBOutlet weak private var potentialReturnsValueLabel: BaseLabel!
    @IBOutlet weak private var nextPayoutDateTitleLabel: BaseLabel!
    @IBOutlet weak private var nextPayoutDateValueLabel: BaseLabel!
    
    @IBOutlet weak private var sigContractLabel: BaseLabel!
    @IBOutlet weak private var sigContractButton: BaseButton!
    @IBOutlet weak private var sigMakeLabel: BaseLabel!
    @IBOutlet weak private var sigMakeButton: BaseButton!
    
    var stringMakePayment: String?
    var dealDetail: COInvestorDealDetailModel? {
        didSet {
            if let myDealDetail = dealDetail {
                loadDataDealCell(myDealDetail)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        sigMakeButton.layer.borderWidth = 2
        sigMakeButton.layer.borderColor = UIColor.redColor().CGColor
        sigMakeLabel.hidden = true
        sigContractLabel.hidden = true
        setTitleForFields()
        separatorFullWidth()
    }
    
    private func setTitleForFields() {
        investmentAmountTitleLabel.text = m_local_string("deal_investment_amount")
        potentialReturnsTitleLabel.text = m_local_string("deal_potential_return")
        nextPayoutDateTitleLabel.text = m_local_string("deal_next_payout_date")
        sigContractLabel.text = m_local_string("deal_contract_sign")
        sigContractButton.setTitle(m_local_string("deal_sign_your_contract"), forState: .Normal)
        sigMakeLabel.text = m_local_string("deal_contract_paid")
        let oldAttribluedString = sigMakeButton.attributedTitleForState(UIControlState.Normal)!
        var range: NSRange = NSRange()
        sigMakeButton.setAttributedTitle(NSAttributedString(string: m_local_string("deal_how_to_make_payment"), attributes: oldAttribluedString.attributesAtIndex(0, effectiveRange: &range)), forState: .Normal)
    }
}

//MARK: Private
extension DealsCell {
    private func showAlertView(message: String, actionComplete: COCompletionDealCell) {
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_DONE")) { (UIMyAlertAction) -> Void in
            actionComplete()
        }
        alert.show()
    }
}

//MARK: Action
extension DealsCell {
    @IBAction func actionSignContract(sender: UIButton) {
        if let myDealDetail = dealDetail {
            showAlertView(myDealDetail.dealOngoingContractInstruction, actionComplete: { () -> Void in
                // code
            })
        }
    }
    
    @IBAction func actionMakePayment(sender: UIButton) {
        if let myDealDetail = dealDetail {
            showAlertView(myDealDetail.dealOngoingPaymentInstruction, actionComplete: { () -> Void in
                // code
            })
        }
    }
}

//MARK: LoadData
extension DealsCell {
    private func loadDataDealCell(dealModel: COInvestorDealDetailModel) {
        projectNameValueLabel.text = dealModel.dealOngoingProjectName
        let amount = FormattedHelper.formartFoatValueWithDeal(dealModel.dealOngoingInvestAmount, min: 2)
        let percent = FormattedHelper.formartFoatValueWithDeal(dealModel.dealOngoingPotentialReturnPercent, min: 0)
        let potential = FormattedHelper.formartFoatValueWithDeal(dealModel.dealOngoingPotentialReturnAmount, min: 0)
        let nextPayout = FormattedHelper.formartFoatValueWithDeal(dealModel.dealOngoingNextPayoutAmount, min: 2)
        investmentAmountValueLabel.text = "\(dealModel.dealOngoingCurrency) \(amount)"
        potentialReturnsValueLabel.text = "(\(percent)%) \(dealModel.dealOngoingCurrency) \(potential)"
        nextPayoutDateValueLabel.text = "\(dealModel.dealOngoingNextPayoutDate) (\(dealModel.dealOngoingCurrency) \(nextPayout))"
        if dealModel.dealOngoingStatus?.dealOngoingStatusIsSigned == true {
            sigContractButton.hidden = true
            sigContractLabel.hidden = false
        } else {
            sigContractButton.hidden = false
            sigContractLabel.hidden = true
        }
        if dealModel.dealOngoingStatus?.dealOngoingStatusIsPaid == true {
            sigMakeButton.hidden = true
            sigMakeLabel.hidden = false
        } else {
            sigMakeButton.hidden = false
            sigMakeLabel.hidden = true
        }
    }
}
