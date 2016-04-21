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
    @IBOutlet weak var loginButton: COAcitvityButton!
    @IBOutlet weak var passWordTextField: COTextFieldBottomLine!
    @IBOutlet weak var userNameTextField: COTextFieldBottomLine!
    @IBOutlet weak var signUplabel: BaseLabel!
    
    @IBOutlet weak var marginLeftLogo: NSLayoutConstraint!
    @IBOutlet weak var marginRightLogo: NSLayoutConstraint!
    @IBOutlet weak var marginTopLogo: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refestUIForDevice()
        setupUI()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func refestUIForDevice() {
        if AppDefine.DeviceType.IsIPpad {
            marginTopLogo.constant = 140
            marginLeftLogo.constant = 145
            marginRightLogo.constant = 145
            let contraintTextField = constraintRatioFortextFiled(5.0/0.7, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/0.7, view: false)
            self.view.addConstraint(contraintButtonLogin)
            userNameTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 20)
            passWordTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 20)
        } else {
            let contraintTextField = constraintRatioFortextFiled(5.0/1.0, view: true)
            self.view.addConstraint(contraintTextField)
            let contraintButtonLogin = constraintRatioFortextFiled(6.0/1.0, view: false)
            self.view.addConstraint(contraintButtonLogin)
            marginTopLogo.constant = 70
            marginLeftLogo.constant = 70
            marginRightLogo.constant = 70
            userNameTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 14)
            passWordTextField.font = UIFont(
                name: AppDefine.AppFontName.COAvenirMedium,
                size: 14)
        }
    }
    
    private func constraintRatioFortextFiled(ratio: CGFloat, view: Bool) -> NSLayoutConstraint {
        if view {
            return NSLayoutConstraint(item: userNameTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: userNameTextField,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        } else {
            return NSLayoutConstraint(item: loginButton,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: loginButton,
                                      attribute: NSLayoutAttribute.Height,
                                      multiplier: ratio,
                                      constant: 0.0)
        }

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupUI() {
        signUplabel.text = m_local_string("TITLE_NEW_USER_SIGN_UP")
        forgotPasswordButton.setTitleColor(AppDefine.AppColor.COGrayColor, forState: UIControlState.Normal)
        passWordTextField.addTarget(self, action: "showForgotPassWord", forControlEvents: UIControlEvents.EditingChanged)
        userNameTextField.title = m_local_string("TITLE_USERNAME")
        passWordTextField.title = m_local_string("TITLE_PASSWORD")
        showForgotPassWord()
    }
}

// MARK: Action
extension LoginViewController {
    @IBAction func actionSignIn(sender: AnyObject) {
        if checkValidation() == true {
            self.loginButton.startAnimating()
            FlowManager.shared.tryToLogin(userNameTextField.text!, password: passWordTextField.text!,
                completion: { (success, error) -> Void in
                    self.loginButton.stopAnimating()
                if let _ = error {
                    UIHelper.showError(error, actionButton: nil)
                } else {
                    ConnectionManager.shared.isFirstTime = true
                    COLoadingView.wakeupAndSync(showWithType: .ShowNone)
                    self.dismiss({ () -> Void in
                        kNotification.postNotificationName(AppDefine.NotificationKey.LoggedIn, object: nil)
                    })
                }
            })
        }
    }
    
    @IBAction func actionSignUp(sender: AnyObject) {
        let signUpVC = SignUpViewController.vc()
        self.pushViewController(signUpVC)
    }
    
    @IBAction func actionForgotPassWord(sender: AnyObject) {
        let forgotPass = ForgotPasswordController.vc()
        self.pushViewController(forgotPass)
    }
    
    @IBAction func actionBackToMenu(sender: AnyObject) {
        FlowManager.shared.home?.offerIdWaiting = nil
        dismiss(nil)
    }
    
    func showForgotPassWord() {
        forgotPasswordButton.hidden = !passWordTextField.text!.isEmpty
    }
    
    func dismiss(completion:(() -> Void)?) {
        if let _ = presentingViewController {
            dismissViewControllerAnimated(true, completion: completion)
        } else {
            toggleLeft()
        }
    }
    
}

//MARK: CheckVerify
extension LoginViewController {
    func checkValidation() -> Bool {
        if userNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_USERNAME"), textfield: userNameTextField)
            return false
        } else if passWordTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PASSWORD"), textfield: passWordTextField)
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
