//
//  SignUpViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/22/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var firstNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var lastNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var phoneTextField: COTextFieldBottomLine!
    @IBOutlet weak private var phoneCodeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var emailTextField: COTextFieldBottomLine!
    @IBOutlet weak private var userNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var passWordTextField: COTextFieldBottomLine!
    @IBOutlet weak private var passWordConfirmationTextField: COTextFieldBottomLine!
    @IBOutlet weak private var buttonSingup: CORedButton!
    @IBOutlet weak private var widthContraintMobileCode: NSLayoutConstraint!
    
    @IBOutlet weak var signInlabel: UILabel!
    
    var selectedPhone: PhoneModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        signInlabel.text = m_local_string("TITLE_ALEADY_HAVE_ACCOUNT")
        firstNameTextField.title = m_local_string("TITLE_FIRSTNAME")
        lastNameTextField.title = m_local_string("TITLE_LASTNAME")
        phoneCodeTextField.title = m_local_string("TITLE_MOBILE_CODE")
        phoneTextField.title = m_local_string("TITLE_MOBILE_NUMBER")
        emailTextField.title = m_local_string("TITLE_EMAIL")
        userNameTextField.title = m_local_string("TITLE_USERNAME")
        passWordTextField.title = m_local_string("TITLE_PASSWORD")
        passWordConfirmationTextField.title = m_local_string("TITLE_CONFIRM_PASSWORD")
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        updateUIForDevice()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func updateUIForDevice() {
        if AppDefine.DeviceType.IsIPpad {
            widthContraintMobileCode.constant = 200
            let contraintTextField = constraintRatioFortextFiled(5.0/0.7, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/0.7, view: false)
            self.view.addConstraint(contraintButtonLogin)
            let font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 20)
            changeFontSize(font!)

        } else {
            widthContraintMobileCode.constant = 100
            let contraintTextField = constraintRatioFortextFiled(5.0/1.0, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/1.0, view: false)
            self.view.addConstraint(contraintButtonLogin)
            let font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 14)
            changeFontSize(font!)
        }
    }
    
    private func constraintRatioFortextFiled(ratio: CGFloat, view: Bool) -> NSLayoutConstraint {
        if view {
            return NSLayoutConstraint(item: firstNameTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: firstNameTextField,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        } else {
            return NSLayoutConstraint(item: buttonSingup,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: buttonSingup,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        }
    }
    
    private func changeFontSize(font: UIFont) {
        firstNameTextField.font = font
        lastNameTextField.font = font
        phoneCodeTextField.font = font
        emailTextField.font = font
        userNameTextField.font = font
        passWordTextField.font = font
        passWordConfirmationTextField.font = font
    }
    
}

//MARK: CheckVerify
extension SignUpViewController {
    private func checkValidation() -> Bool {
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
        } else if ValidHelper.isValidatePhoneNumber(phoneTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_PHONE_VALID"), textfield: phoneTextField)
            return false
        } else if userNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_USERNAME"), textfield: userNameTextField)
            return false
        } else if passWordTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PASSWORD"), textfield: passWordTextField)
            return false
        } else if passWordConfirmationTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_CONFIRM_PASSWORD"), textfield: passWordConfirmationTextField)
            return false
        } else if passWordTextField.text != passWordConfirmationTextField.text {
            showAlertView(m_local_string("MESSAGE_CONFIRM_PASSWORD_MATCH"), textfield: passWordConfirmationTextField)
            return false
        }
        
        return true
    }
    
    private func showAlertView(message: String, textfield: UITextField) {
        self.view.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) {(AlertAction) -> Void in
            textfield.becomeFirstResponder()
        }
        alert.show()
    }
}

//MARK: Action
extension SignUpViewController {
    @IBAction func actionLogin(sender: AnyObject) {
        self.popToRootViewController()
    }
    
    @IBAction func actionChoicePhoneCode(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COPhoneDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("APP_NAME")
        dropList.selectedPhone = self.selectedPhone
        dropList.completion = {(selectedPhone: PhoneModel?) -> Void in
            self.selectedPhone = selectedPhone
            self.phoneCodeTextField.text = selectedPhone?.shortStringFormat()
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionSignUp(sender: AnyObject) {
        if checkValidation() {
            self.view.endEditing(true)
            UIHelper.showLoadingInView()
            let userService = UserService()
            var body = userService.createParams()
            body[ServiceDefine.UserField.FirstName] = firstNameTextField.text!
            body[ServiceDefine.UserField.LastName] = lastNameTextField.text!
            body[ServiceDefine.UserField.Email] = emailTextField.text!
            body[ServiceDefine.UserField.CountryCode] = phoneCodeTextField.text!
            body[ServiceDefine.UserField.CellPhone] = phoneTextField.text!
            body[ServiceDefine.UserField.UserName] = userNameTextField.text!
            body[ServiceDefine.UserField.Password] = passWordTextField.text!
            UserService().registerUser(body, completion: { (success, error) -> Void in
                if success == true && error == nil {
                    FlowManager.shared.tryToLogin(
                        self.userNameTextField.text!,
                        password: self.passWordTextField.text!,
                        completion: { (success, error) -> Void in
                            UIHelper.hideLoadingFromView()
                        if let _ = error {
                            UIHelper.showError(error, actionButton: nil)
                        } else {
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                COLoadingView.wakeupAndSync(showWithType: .ShowNone)
                                self.dismiss()
                            })
                        }
                    })
                } else {
                    UIHelper.hideLoadingFromView()
                    UIHelper.showError(error, actionButton: nil)
                }
            })
        }
    }
    
    func dismiss() {
        if let _ =  presentingViewController {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
