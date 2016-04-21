//
//  UpdateProfileViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class UpdateProfileViewController: BaseViewController {
    
    @IBOutlet weak private var firstNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var lastNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var emailTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryCodeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var phoneTextField: COTextFieldBottomLine!
    @IBOutlet weak private var address1TextField: COTextFieldBottomLine!
    @IBOutlet weak private var address2TextField: COTextFieldBottomLine!
    @IBOutlet weak private var cityTextField: COTextFieldBottomLine!
    @IBOutlet weak private var postalCodeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var regionStateTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryTextField: COTextFieldBottomLine!
    @IBOutlet weak private var bottomButton: CORedButton!
    @IBOutlet weak private var widthContraintMobileCode: NSLayoutConstraint!
    //MARK: - Variable
    var selectedCode: String?
    
    var userProfile: COUserProfileModel {
        return ProfileContainer.userProfileModel
    }
    
    lazy var phoneCodeSelectedIndex: Int = {
        return 0
    }()
    
    //MARK: - override
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        updateUIForDevice()
        setTitleForFields()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setTitleForFields() {
        firstNameTextField.title = m_local_string("TITLE_FIRST_NAME")
        lastNameTextField.title = m_local_string("TITLE_LAST_NAME")
        emailTextField.title = m_local_string("TITLE_EMAIL_ADDRESS")
        countryCodeTextField.title = m_local_string("TITLE_COUNTRY_CODE")
        phoneTextField.title = m_local_string("TITLE_CELL_PHONE")
        address1TextField.title = m_local_string("TITLE_ADDRESS1")
        address2TextField.title = m_local_string("TITLE_ADDRESS2")
        cityTextField.title = m_local_string("TITLE_CITY")
        postalCodeTextField.title = m_local_string("TITLE_POSTAL_CODE")
        regionStateTextField.title = m_local_string("TITLE_REGION_STATE")
        countryTextField.title = m_local_string("TITLE_COUNTRY")
        bottomButton.setTitle(m_local_string("TITLE_DONE_UPDATE"), forState: .Normal)
    }
    
    private func refreshUI() {
        kMainQueue.addOperationWithBlock { () -> Void in
            self.firstNameTextField.text = self.userProfile.firstName
            self.lastNameTextField.text = self.userProfile.lastName
            self.emailTextField.text = self.userProfile.email
            self.countryCodeTextField.text = "+" + (self.userProfile.profile?.countryPrefix)!
            self.phoneTextField.text = self.userProfile.profile?.cellphone
            self.address1TextField.text = self.userProfile.profile?.address1
            self.address2TextField.text = self.userProfile.profile?.address2
            self.cityTextField.text = self.userProfile.profile?.city
            self.postalCodeTextField.text = self.userProfile.profile?.postalCode
            self.regionStateTextField.text = self.userProfile.profile?.regionState
            self.countryTextField.text = self.userProfile.profile?.country
            self.selectedCode = self.userProfile.profile?.countryPrefix
        }
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
        firstNameTextField.font = font
        lastNameTextField.font = font
        countryCodeTextField.font = font
        emailTextField.font = font
        phoneTextField.font = font
        address1TextField.font = font
        address2TextField.font = font
        cityTextField.font = font
        postalCodeTextField.font = font
        regionStateTextField.font = font
        countryTextField.font = font
    }
    
}

//MARK: CheckVerify
extension UpdateProfileViewController {
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
        } else if emailTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_EMAIL"), textfield: emailTextField)
            return false
        } else if ValidHelper.isValidEmail(emailTextField.text!) == false {
            showAlertView(m_local_string("MESSAGE_EMAIL_VALID"), textfield: emailTextField)
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
extension UpdateProfileViewController {
    @IBAction func actionChoicePhoneCode(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COPhoneDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("APP_NAME")
        dropList.selectedCode = self.selectedCode
        dropList.completion = {(selectedPhone: PhoneModel?) -> Void in
            self.selectedCode = selectedPhone?.code
            self.countryCodeTextField.text = selectedPhone?.shortStringFormat()
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionUpdate(sender: AnyObject) {
        if checkValidation() {
            UIHelper.showLoadingInView()
            let profileService = ProfileService()
            var body = profileService.createParams()
            body[ServiceDefine.UserField.FirstName] = firstNameTextField.text!
            body[ServiceDefine.UserField.LastName] = lastNameTextField.text!
            body[ServiceDefine.UserField.Email] = emailTextField.text!
            body[ServiceDefine.UserField.CountryCode] = countryCodeTextField.text!.trimmingCharacters("+")
            body[ServiceDefine.UserField.CellPhone] = phoneTextField.text!
            body[ServiceDefine.UserProfileDetailField.Address1] = address1TextField.text!
            body[ServiceDefine.UserProfileDetailField.Address2] = address2TextField.text!
            body[ServiceDefine.UserProfileDetailField.City] = cityTextField.text!
            body[ServiceDefine.UserProfileDetailField.PostalCode] = postalCodeTextField.text!
            body[ServiceDefine.UserProfileDetailField.Country] = countryTextField.text!
            body[ServiceDefine.UserProfileDetailField.RegionState] = regionStateTextField.text!
            ProfileService().updateUserProfile(body, completion: { (success, error) -> Void in
                UIHelper.hideLoadingFromView()
                if success == true && error == nil {
                    self.popViewController()
                } else {
                    UIHelper.showError(error, actionButton: nil)
                }
            })
        }
    }
    
    @IBAction func actionBackVC(sender: AnyObject) {
        self.popToRootViewController(true)
    }
}
