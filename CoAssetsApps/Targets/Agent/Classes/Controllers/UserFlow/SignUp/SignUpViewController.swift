//
//  SignUpViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/22/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var firstNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var lastNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var genderTextField: COTextFieldBottomLine!
    @IBOutlet weak private var salutionTextField: COTextFieldBottomLine!
    @IBOutlet weak private var dateofBirthTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryCodeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var phoneTextField: COTextFieldBottomLine!
    @IBOutlet weak private var emailTextField: COTextFieldBottomLine!
    @IBOutlet weak private var adressTextField: COTextFieldBottomLine!
    @IBOutlet weak private var cityTextField: COTextFieldBottomLine!
    @IBOutlet weak private var postalCodeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryTextField: COTextFieldBottomLine!
    @IBOutlet weak private var userNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var passWordTextField: COTextFieldBottomLine!
    @IBOutlet weak private var passWordConfirmationTextField: COTextFieldBottomLine!

    
    private lazy var toolBar: UIToolbar? = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.blackColor()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "donePressed:")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPressed:")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
        
    }()
    
    private lazy var pickerDate:UIDatePicker? = {
        let picker = UIDatePicker()
        picker.datePickerMode = UIDatePickerMode.Date
        let currentDate = NSDate()
        let data = DateHelper.getDateFromString("1/1/1990")
        
        picker.maximumDate = currentDate
        picker.date = data
        picker.addTarget(self, action: "actionChangeDate:", forControlEvents: UIControlEvents.ValueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateofBirthTextField.delegate = self
        dateofBirthTextField.inputAccessoryView = toolBar
        dateofBirthTextField.inputView = pickerDate
    }
}

//MARK: CheckVerify
extension SignUpViewController {
    private func checkVerify() -> Bool {
        if firstNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_FIRST_NAME"), textfield: firstNameTextField)
            return false
        } else if lastNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_LAST_NAME"), textfield: lastNameTextField)
            return false
        } else if phoneTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_PHONE"), textfield: phoneTextField)
            return false
        } else if ValidHelper.isValidatePhoneNumber(phoneTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_PHONE_VALID"), textfield: phoneTextField)
            return false
        } else if emailTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_EMAIL"), textfield: emailTextField)
            return false
        } else if ValidHelper.isValidEmail(emailTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_EMAIL_VALID"), textfield: emailTextField)
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
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            textfield.becomeFirstResponder()
        }
        alert.show()
    }
}

//MARK: Action
extension SignUpViewController {
    
    func donePressed(sender: AnyObject) {
        view.endEditing(true)
        dateofBirthTextField.text = DateHelper.getStringFromDate(pickerDate!.date)
    }
    
    func cancelPressed(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func actionLogin(sender: AnyObject) {
        self.popToRootViewController()
    }
    
    @IBAction func actionSignUp(sender: AnyObject) {
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
    
    func actionChangeDate(sender: AnyObject) {
//        dateofBirthTextField.text = DateHelper.getStringFromDate(pickerDate!.date)
    }
    
    @IBAction func actionGender(sender: AnyObject) {
        UIHelper.actionSheet("select", message: "Selected gender", viewController: self) { (title) -> Void in
            self.genderTextField.text = title
        }
    }
}