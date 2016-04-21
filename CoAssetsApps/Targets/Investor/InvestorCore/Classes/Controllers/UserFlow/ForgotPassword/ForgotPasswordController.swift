//
//  ForgotPasswordController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ForgotPasswordController: BaseViewController {
    @IBOutlet weak var emailAddressTextField: COTextFieldBottomLine!
    @IBOutlet weak var backToSignInlabel: BaseLabel!
    @IBOutlet weak var descriptionLabel: BaseLabel!
    @IBOutlet weak var resetPasswordButton: CORedButton!
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        refestUIForDevice()
        emailAddressTextField.title = m_local_string("TITLE_EMAIL")
        backToSignInlabel.text = m_local_string("TITLE_BACK_TO_SIGNIN")
        resetPasswordButton.setTitle(m_local_string("TITLE_RESET_PASSWORD"), forState: UIControlState.Normal)
        descriptionLabel.text = m_local_string("FORGOTPASSWORD_DESCRIPTION")
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func refestUIForDevice() {
        if AppDefine.DeviceType.IsIPpad {
            let contraintTextField = constraintRatioFortextFiled(5.0/0.7, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/0.7, view: false)
            self.view.addConstraint(contraintButtonLogin)
            emailAddressTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 20)
        } else {
            let contraintTextField = constraintRatioFortextFiled(5.0/1.0, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/1.0, view: false)
            self.view.addConstraint(contraintButtonLogin)
            emailAddressTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 14)
        }
    }
    
    private func constraintRatioFortextFiled(ratio: CGFloat, view: Bool) -> NSLayoutConstraint {
        if view {
            return NSLayoutConstraint(item: emailAddressTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: emailAddressTextField,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        } else {
            return NSLayoutConstraint(item: resetPasswordButton,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: resetPasswordButton,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        }
        
    }
    
}

//MARK: Action
extension ForgotPasswordController {
    @IBAction func actionBackToLogin(sender: AnyObject) {
        self.popViewController()
    }
    
    @IBAction func actionResetPasssword(sender: AnyObject) {
        if checkValidation() {
            UIHelper.showLoadingInView()
            UserService().forgotPassword(emailAddressTextField.text!, completion: { (success, error) -> Void in
                UIHelper.hideLoadingFromView()
                if success == true && error == nil {
                    self.popToRootViewController()
                } else {
                    UIHelper.showError(error, actionButton: nil)
                }
            })
        }
    }
}

//MARK: CheckVerify
extension ForgotPasswordController {
    private func checkValidation() -> Bool {
        if emailAddressTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_EMAIL"), textfield: emailAddressTextField)
            return false
        } else if ValidHelper.isValidEmail(emailAddressTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_EMAIL_VALID"), textfield: emailAddressTextField)
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
