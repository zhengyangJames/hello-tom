//
//  RequestViewController.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class RequestViewController: BaseViewController {
    
    @IBOutlet weak private var titleSignUpLabel: UILabel!
    @IBOutlet weak private var emailTextField: COTextFieldBottomLine!
    @IBOutlet weak private var firstNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var lastNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var phoneTextField: COTextFieldBottomLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//MARK: CheckVerify
extension RequestViewController {
    private func checkVerify() -> Bool {
        if firstNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_FIRST_NAME"), textfield: firstNameTextField)
            return false
        } else if lastNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_LAST_NAME"), textfield: lastNameTextField)
            return false
        } else if emailTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_EMAIL"), textfield: emailTextField)
            return false
        } else if ValidHelper.isValidEmail(emailTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_EMAIL_VALID"), textfield: emailTextField)
            return false
        } else if phoneTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PHONE"), textfield: phoneTextField)
            return false
        }else if ValidHelper.isValidatePhoneNumber(phoneTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_PHONE_VALID"), textfield: phoneTextField)
            return false
        }
        return true
    }
    
    private func showAlertView(message: String, textfield: UITextField) {
        self.view.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            textfield.becomeFirstResponder()
        }
        alert.show()
    }
}

//MARK: Action
extension RequestViewController {
    @IBAction func actionSignUp(sender:AnyObject) {
        let signUpVC = SignUpViewController(nibName: SignUpViewController.className, bundle: nil)
        self.pushViewController(signUpVC)
    }
    
    @IBAction func actionRequest(sender: AnyObject) {
        if checkVerify() == true {
            self.view.endEditing(true)
            let alert = UIHelper.alertView(nil, message: m_local_string("MESSAGE_REQUEST_LOGIN"))
            alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (UIMyAlertAction) -> Void in
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    kUserDefault.setBool(true, forKey: AppDefine.UserDefaultKey.LoggedIn)
                    kUserDefault.synchronize()
                    kAppDelegate!.setupAfterLoginFlow()
                })
            }
            alert.show()
        }
    }
}