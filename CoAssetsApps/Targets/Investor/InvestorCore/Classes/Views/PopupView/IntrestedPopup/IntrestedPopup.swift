//
//  IntrestedPopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit


class IntrestedPopup: BasePopup {
    
    @IBOutlet weak private var emailTextField: COBoderColorTextField!
    @IBOutlet weak private var amountTexfield: COBoderColorTextField!
    @IBOutlet weak private var checkBoxButton: COCheckButton!
    @IBOutlet weak private var bottomContrain: NSLayoutConstraint!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var shortDescriptionLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var amountLabel: UILabel!
    @IBOutlet weak private var checkboxTitleLabel: UILabel!
    @IBOutlet weak private var doneButton: CORedButton!
    
    weak var parentView: InvestView?
    
    var callBack: ((email: String, amount: String) -> Void)?
    
    override func keyboardWillShow(notification: NSNotification) {
        super.keyboardWillShow(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        if let infoValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue, durationTempNumber = durationTemp as? NSNumber {
            let keyboardFrame: CGRect = infoValue.CGRectValue()
            let duration = NSTimeInterval(durationTempNumber)
            UIView.animateWithDuration(duration) { () -> Void in
                self.bottomContrain.constant = keyboardFrame.size.height
                self.layoutIfNeeded()
            }
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        super.keyboardWillHide(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        if let durationNumber = durationTemp as? NSNumber {
            let duration = NSTimeInterval(durationNumber)
            UIView.animateWithDuration(duration) {() -> Void in
                self.bottomContrain.constant = 8.0
                self.layoutIfNeeded()
            }
        }
        
    }
    
    func loadData() {
        titleLabel.text = m_local_string("INTERESTED_TITLE")
        shortDescriptionLabel.text = m_local_string("Expressing_Interest_Home")
        emailLabel.text = m_local_string("Verify_Your_Email_Home")
        amountLabel.text = m_local_string("Provide_Indicative_Home")
        checkboxTitleLabel.text = m_local_string("CoAssets_Share_Home")
        doneButton.setTitle(m_local_string("DONE_TITLE"), forState: UIControlState.Normal)
        amountTexfield.text = String(format: "%.0f", parentView!.parentController.offerModel.minInvesmentNotNil)
        emailTextField.text = ProfileContainer.userProfileModel.email
    }
}

//MARK: - Static func
extension IntrestedPopup {
    class func showIntrestedPopup(parentView: InvestView, callBack: ((email: String, amount: String) -> Void)) -> IntrestedPopup? {
        if let intrested = UIView.awakeFromNib(IntrestedPopup.className) as? IntrestedPopup {
            intrested.callBack = callBack
            intrested.parentView = parentView
            intrested.translatesAutoresizingMaskIntoConstraints = false
            if let delegate = UIApplication.sharedApplication().delegate, window = delegate.window {
                window!.addSubview(intrested)
                intrested.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
                intrested.loadData()
                return intrested
            }
        }
        return nil
    }
}

//MARK: CheckVerify
extension IntrestedPopup {
    private func checkVerify() -> Bool {
        if emailTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_EMAIL"), textfield: emailTextField)
            return false
        } else if ValidHelper.isValidEmail(emailTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_EMAIL_VALID"), textfield: emailTextField)
            return false
        } else if amountTexfield.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_amount"), textfield: amountTexfield)
            return false
        } else if !isValidAmount() {
            let message = String(format: m_local_string("MESSAGE_AMOUNT_MINIMUM"), parentView!.parentController.offerModel.minInvesmentNotNil)
            showAlertView(message, textfield: amountTexfield)
            return false
        } else if checkBoxButton.isCheck == false {
            showAlertView(m_local_string("MESSAGE_NO_CHECK"), textfield: amountTexfield)
            return false
        }
        return true
    }
    
    private func isValidAmount() -> Bool {
        let currencyFormatter = NSNumberFormatter()
        if let number = currencyFormatter.numberFromString(amountTexfield.text!) {
            return number.doubleValue >= parentView!.parentController.offerModel.minInvesmentNotNil
        }
        return false
    }
    
    private func showAlertView(message: String, textfield: UITextField) {
        self.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            textfield.performSelector("becomeFirstResponder", withObject: nil, afterDelay: 0.5)
        }
        alert.show()
    }
}

//MARK: Action
extension IntrestedPopup {
    @IBAction func actionClose(sender: AnyObject) {
        self.popView()
    }
    
    @IBAction func actionSubmit(sender: AnyObject) {
        if checkVerify() == true {
            self.endEditing(true)
            self.callBack!(email: emailTextField.text!.trim(), amount: amountTexfield.text!.trim())
        }
    }
    
    @IBAction func actionCheck(sender: COCheckButton) {
        if sender.isCheck == false {
            sender.isCheck = true
        } else {
            sender.isCheck = false
        }
    }
}

// MARK: - UITextFieldDelegate

extension IntrestedPopup: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTexfield {
            var text = string
            if textField.text != nil {
                text = NSString(string: textField.text!).stringByReplacingCharactersInRange(range, withString: string) as String
            }
            let currencyFormatter = NSNumberFormatter()
            let number = currencyFormatter.numberFromString(text)
            if text.length > 0 && (number == nil || number!.integerValue < 0) {
                return false
            }
        }
        return true
    }
    
}
