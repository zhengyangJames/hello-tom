//
//  LoginViewController.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var forgotPasswordButton: COButton!
    @IBOutlet weak var passWordTextField: COTextFieldBottomLine!
    @IBOutlet weak var userNameTextField: COTextFieldBottomLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        forgotPasswordButton.setTitleColor(AppDefine.AppColor.COGrayColor, forState: UIControlState.Normal)
        passWordTextField.addTarget(self, action: "showForgotPassWord", forControlEvents: UIControlEvents.EditingChanged)
        showForgotPassWord()
    }
}

// MARK: Action
extension LoginViewController {
    @IBAction func actionSignIn(sender:AnyObject) {
        if checkVerify() == true {
            let registerVC = RequestViewController(nibName:RequestViewController.className, bundle: nil)
            self.pushViewController(registerVC)
        }
    }
    
    @IBAction func actionSignUp(sender: AnyObject) {
        let signUpVC = SignUpViewController(nibName: SignUpViewController.className, bundle: nil)
        self.pushViewController(signUpVC)
    }
    
    @IBAction func actionForgotPassWord(sender: AnyObject) {
        
    }
    
    func showForgotPassWord() {
        forgotPasswordButton.hidden = !passWordTextField.text!.isEmpty
    }
    
}

//MARK: CheckVerify
extension LoginViewController {
    func checkVerify() -> Bool {
        if userNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_USERNAME"),textfield:userNameTextField)
            return false
        } else if passWordTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PASSWORD"),textfield:passWordTextField)
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