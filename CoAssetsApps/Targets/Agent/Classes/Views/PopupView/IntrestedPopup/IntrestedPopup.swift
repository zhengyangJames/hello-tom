//
//  IntrestedPopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

public typealias Completion = (data: AnyObject?, error:NSError?) -> Void

class IntrestedPopup: BasePopup {
    
    @IBOutlet weak private var emailTextField: COBoderColorTextField!
    @IBOutlet weak private var countryTexfield: COBoderColorTextField!
    @IBOutlet weak private var phoneTexfield: COBoderColorTextField!
    @IBOutlet weak private var amountTexfield: COBoderColorTextField!
    @IBOutlet weak private var checkBoxButton: COCheckButton!
    @IBOutlet weak private var bottomContrain: NSLayoutConstraint!
    
    var complete: Completion?
    
    override func keyboardWillShow(notification: NSNotification) {
        super.keyboardWillShow(notification)
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        let duration = NSTimeInterval(durationTemp as! NSNumber)
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomContrain.constant = keyboardFrame.size.height
            self.layoutIfNeeded()
        }
    }
    override func keyboardWillHide(notification: NSNotification) {
        super.keyboardWillHide(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        let duration = NSTimeInterval(durationTemp as! NSNumber)
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomContrain.constant = 8.0
            self.layoutIfNeeded()
        }
    }

}

//MARK: - Static func
extension IntrestedPopup {
    class func showQuestionPopup(parentView: UIView, complete: Completion) {
        let questionPopup = UIView.loadFromNibNamed("IntrestedPopup") as! IntrestedPopup
        questionPopup.complete = complete
        questionPopup.translatesAutoresizingMaskIntoConstraints = false
        var window: UIWindow!
        if let temp = UIApplication.sharedApplication().delegate?.window {
            window = temp
        } else {
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            (UIApplication.sharedApplication().delegate as! AppDelegate).window = window
            window.makeKeyAndVisible()
        }
        window.addSubview(questionPopup)
        questionPopup.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
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
        } else if countryTexfield.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_COUNTRY_CODE"), textfield: countryTexfield)
            return false
        } else if phoneTexfield.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PHONE"), textfield: phoneTexfield)
            return false
        }  else if amountTexfield.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_amount"), textfield: amountTexfield)
            return false
        } else if checkBoxButton.isCheck == false {
            showAlertView(m_local_string("MESSAGE_NO_CHECK"), textfield: amountTexfield)
            return false
        }
        return true
    }
    
    private func showAlertView(message: String, textfield: UITextField) {
        self.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            textfield.becomeFirstResponder()
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
            let alert = UIHelper.alertView(nil, message: m_local_string("MESSAGE_IM_INTRESTER_INVEST"))
            alert.addButtonWithAction(m_local_string(m_local_string("TITLE_DONE"))) { (UIMyAlertAction) -> Void in
                self.complete!(data:nil, error: nil)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.popView()
                })
            }
            alert.show()
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