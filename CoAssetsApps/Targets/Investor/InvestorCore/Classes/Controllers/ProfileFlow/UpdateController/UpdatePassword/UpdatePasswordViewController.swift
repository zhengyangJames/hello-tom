//
//  UpdatePasswordViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: BaseViewController {
    
    @IBOutlet weak private var newPasswordTextField: COTextFieldBottomLine!
    @IBOutlet weak private var confirmPasswordTextField: COTextFieldBottomLine!
    @IBOutlet weak private var bottomButton: CORedButton!
    
    private var boxTextField: UITextField?
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIForDevice()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupUI() {
        newPasswordTextField.becomeFirstResponder()
        newPasswordTextField.title = m_local_string("NEW_PASSWORD")
        confirmPasswordTextField.title = m_local_string("CONFIRM_PASSWORD")
        bottomButton.setTitle(m_local_string("TITLE_DONE_UPDATE"), forState: .Normal)
    }
    
    private func updateUIForDevice() {
        if AppDefine.DeviceType.IsIPpad {
            let contraintTextField = constraintRatioFortextFiled(5.0/0.7, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/0.7, view: false)
            self.view.addConstraint(contraintButtonLogin)
            let font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 20)
            changeFontSize(font!)
            
        } else {
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
            return NSLayoutConstraint(item: newPasswordTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: newPasswordTextField,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        } else {
            return NSLayoutConstraint(item: bottomButton,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: bottomButton,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        }
    }
    
    private func changeFontSize(font: UIFont) {
        newPasswordTextField.font = font
        confirmPasswordTextField.font = font
    }
    
}

//MARK: Private
extension UpdatePasswordViewController {
    func checkVerifyPass() -> Bool {
        if newPasswordTextField.text?.isEmpty == true {
            showAlertView(m_local_string("newPasswordRequired"), type: "new")
            return false
        } else if confirmPasswordTextField.text?.isEmpty == true {
            showAlertView(m_local_string("ConfirmPasswordRequired"), type: "confi")
            return false
        } else if confirmPasswordTextField.text != newPasswordTextField.text {
            showAlertView(m_local_string("ConfirmPasswordMessage"), type: "confi")
            return false
        }
        return true
    }

    private func showAlertView(message: String, type: String) {
        self.view.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (UIAlertAction) -> Void in
        }
        alert.show()
    }
    
   }

//MARK: Action
extension UpdatePasswordViewController {
    @IBAction private func actionBack(sender: UIButton) {
        self.view.endEditing(true)
        self.popToRootViewController(true)
    }
    
    @IBAction private func actionDone(sender: UIButton) {
        if checkVerifyPass() == true {
            self.view.endEditing(true)
            UIHelper.showLoadingInView()
            let userService = UserService()
            var body = userService.createParams()
            body[ServiceDefine.UserField.NewPassword] = newPasswordTextField.text!
            UserService().updatePassword(body, completion: { (data, error) -> Void in
                UIHelper.hideLoadingFromView()
                if let _ = error {
                    self.showAlert(m_local_string("PASSWORD_NOT_CHANGED"), tag: 0)
                } else {
                    self.showAlert(m_local_string("PASSWORD_CHANGE_SUCCESSFULLY"), tag: 1)
                }
            })
        }
    }
    
    func showAlert(message: String, tag: Int) {
        self.view.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            if alert.tag == 1 {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        alert.show()
        alert.tag = tag
    }
}
