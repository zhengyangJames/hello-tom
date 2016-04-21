//
//  FormCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc
protocol FormCellDelegate: NSObjectProtocol {
    optional func actionShowDropList(cell: FormCell)
}

class FormCell: UITableViewCell, UIAlertViewDelegate {
    
    @IBOutlet weak private var dropButton: CODropDownButton!
    @IBOutlet weak private var amountTextField: COTextFieldBottomLine!
    @IBOutlet weak private var withdrawalFormLabel: BaseLabel!
    @IBOutlet weak private var currencyTextField: COTextFieldBottomLine!
    @IBOutlet weak private var withdrawButton: BaseButton!
    
    var availableBalanceArray: [COPortfolioBalanceModel]? {
        didSet {
            createBalancesArray(availableBalanceArray)
            createCurrencyDropDown()
        }
    }
    var currencyList: [CurrencyListModel]?
    var dropDownList: COCurrencyDropList?
    var selectedCode: String?
    var index = 0
    var controller: UIViewController?
    weak var delegate: FormCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleForFields()
        amountTextField.isShowDropImage = true
        currencyTextField.isShowDropImage = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        withdrawalFormLabel.font = UIFont(
            name: AppDefine.AppFontName.COAvenirBlack,
            size: withdrawalFormLabel.font.pointSize)
        amountTextField.title = m_local_string("Currency")
        amountTextField.textColor = UIColor.blackColor()
        amountTextField.font = UIFont(
            name: AppDefine.AppFontName.COAvenirMedium,
            size: withdrawalFormLabel.font.pointSize)
        currencyTextField.textColor = UIColor.blackColor()
        currencyTextField.title = m_local_string("portfolio_amount")
    }
    
    private func setTitleForFields() {
        withdrawalFormLabel.text = m_local_string("portfolio_withdraw_form")
        withdrawButton.setTitle(m_local_string("portfolio_withdraw"), forState: .Normal)
    }
    
    @IBAction func actionInvestor(sender: UIButton) {
        if let delegate = delegate {
            delegate.actionShowDropList?(self)
        }
        controller?.view.endEditing(true)
        if let dropDownList = dropDownList {
            controller?.presentViewController(dropDownList, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionWithDraw(sender: UIButton) {
        if let availableBalanceArray = availableBalanceArray {
            let balanceModel = availableBalanceArray[index]
            let number = balanceModel.balanceAmt
            if !amountTextField.text!.isEmpty {
                let doubleValid = ValidHelper.stringIsDecimalNumber(amountTextField.text!)
                if doubleValid {
                    if Double(amountTextField.text!) <= Double(number) {
                        amountTextField.endEditing(true)
                        checkconditionSuccess(amountTextField.text!)
                    } else {
                        let message = NSString().stringByAppendingFormat("%@ %@", m_local_string("MESSAGE_TEXTFIELD_MAX_AMOUNT"), String(number))
                        showAlertView(message as String)
                    }
                } else {
                    showAlertView(m_local_string("MESSAGE_TEXTFIELD_VALID"))
                }
            } else {
                showAlertView(m_local_string("MESSAGE_TEXTFIELD_NULL"))
            }
        }
    }
    
    func createBalancesArray(array: [COPortfolioBalanceModel]?) {
        if let array = array {
            var result = [CurrencyListModel]()
            for diction in array {
                let currencyModel = CurrencyListModel(code: diction.currency, name: diction.currencyName())
                result.append(currencyModel)
            }
            self.currencyList = result
        }
    }
    
    func createCurrencyDropDown() {
        let dropList = COCurrencyDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("APP_NAME")
        dropList.selectedCode = self.selectedCode
        if let list = currencyList {
            dropList.currency = list
            if list.isEmpty == false {
                currencyTextField.text = list[0].stringFormat()
                dropList.selectedCode = list[0].code
                self.selectedCode = dropList.selectedCode
                print(currencyTextField.text)
            }
        }
        dropList.completion = {(selected: CurrencyListModel?) -> Void in
            self.selectedCode = selected?.code
            self.currencyTextField.text = self.currencyNameWithCode(self.selectedCode)
            if let arrayCur = self.availableBalanceArray {
                let arrayFilter = arrayCur.filter({ (object: COPortfolioBalanceModel) -> Bool in
                    object.currency == selected?.code
                })
                if arrayFilter.isEmpty == false {
                    self.index = arrayCur.indexOf(arrayFilter.first!) ?? 0
                }
            }
        }
        dropDownList = dropList
    }
    
    func checkconditionSuccess(amount: String) {
        postPortfolioWidthdraw(amount)
    }
    
    func showAlertView(message: String) {
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { () -> Void in
            alert.dismiss()
        }
        alert.show()
    }
    
    private func postPortfolioWidthdraw(amount: String) {
        let service = ProfileService()
        var body = service.createParams()
        body[ServiceDefine.PortfolioBalanceField.Currency] = self.selectedCode
        body[ServiceDefine.PortfolioBalanceField.amount] = amount
        body[ServiceDefine.UserField.UserName] = ProfileContainer.userProfileModel.userName
        UIHelper.showLoadingInView()
        service.postPortfolioWidthdraw(body) { (data, error) in
            if let dicData = data, message = dicData["message"].string {
                self.showAlertView(message)
            }
            UIHelper.hideLoadingFromView()
        }
    }
    
    func currencyNameWithCode(code: String?) -> String {
        guard let tempArray = ResourcesHelper.readPlistFile("Currency") where code != nil else {
            return ""
        }
        let arrayName = (tempArray as? Array)?.filter { (dic: [String:String]) -> Bool in
            if dic["code"] == code { return true } else { return false }
        }
        guard let names = arrayName where names.isEmpty == false else {
            return ""
        }
        return names.first!["name"]!
    }
}
