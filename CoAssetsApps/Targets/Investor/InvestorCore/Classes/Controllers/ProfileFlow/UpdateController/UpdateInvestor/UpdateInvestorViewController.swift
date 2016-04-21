//
//  UpdateInvestorViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class UpdateInvestorViewController: BaseViewController {

    @IBOutlet weak private var investorTypeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var projectPreferenceTextField: COTextFieldBottomLine!
    @IBOutlet weak private var currencyTextField: COTextFieldBottomLine!
    @IBOutlet weak private var investmentBudgetTextField: COTextFieldBottomLine!
    @IBOutlet weak private var durationPreferenceTextField: COTextFieldBottomLine!
    @IBOutlet weak private var targetReturnTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryPreferenceTextField: COTextFieldBottomLine!
    @IBOutlet weak private var descriptionTextField: COTextFieldBottomLine!
    @IBOutlet weak private var websiteTextField: COTextFieldBottomLine!
    @IBOutlet weak private var bottomButton: CORedButton!
    
    var userInvestProfile: COInvestorProfileModel {
        return ProfileContainer.investorProfileModel
    }
    
    var selectedInvestorCode: String?
    var selectedProjectCode: String?
    var selectedCurrencyCode: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUIForDevice()
        setupUIForFields()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupUI() {
        if NSThread.isMainThread() {
            updateDataInMainThread()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.updateDataInMainThread()
            }
        }
    }
    
    private func updateDataInMainThread() {
        investorTypeTextField.text = userInvestProfile.getNameForCode(ServiceDefine.InvestorListType.TypeInvestor)
        currencyTextField.text = userInvestProfile.getNameForCode(ServiceDefine.InvestorListType.TypeCurrency)
        projectPreferenceTextField.text = userInvestProfile.getNameForCode(ServiceDefine.InvestorListType.TypeProject)
        investmentBudgetTextField.text = String(userInvestProfile.investment)
        durationPreferenceTextField.text = String(userInvestProfile.duration)
        targetReturnTextField.text = String(userInvestProfile.targetAnnualizeReturn)
        countryPreferenceTextField.text = userInvestProfile.country
        descriptionTextField.text = userInvestProfile.descriptions
        websiteTextField.text = userInvestProfile.website
        selectedInvestorCode = userInvestProfile.investorType
        selectedCurrencyCode = userInvestProfile.currencyPrference
        selectedProjectCode = userInvestProfile.projectType
    }
    
    private func setupUIForFields() {
        investorTypeTextField.isShowDropImage = true
        projectPreferenceTextField.isShowDropImage = true
        currencyTextField.isShowDropImage = true
        setTitleForFields()
    }
    
    private func setTitleForFields() {
        investorTypeTextField.title = m_local_string("InvestorType")
        projectPreferenceTextField.title = m_local_string("ProjectPreference")
        currencyTextField.title = m_local_string("Currency")
        investmentBudgetTextField.title = m_local_string("InvestmentBudget")
        durationPreferenceTextField.title = m_local_string("DurationPreference")
        targetReturnTextField.title = m_local_string("TargetReturn")
        countryPreferenceTextField.title = m_local_string("CountryPreference")
        descriptionTextField.title = m_local_string("Description")
        websiteTextField.title = m_local_string("Website")
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
            return NSLayoutConstraint(item: investorTypeTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: investorTypeTextField,
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
        investorTypeTextField.font = font
        projectPreferenceTextField.font = font
        currencyTextField.font = font
        investmentBudgetTextField.font = font
        durationPreferenceTextField.font = font
        targetReturnTextField.font = font
        countryPreferenceTextField.font = font
        descriptionTextField.font = font
        websiteTextField.font = font
    }
    
}
//MARK: Actions
extension UpdateInvestorViewController {
    @IBAction func actionChoiceInvestorType(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COInvestorDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("INVESTOR_TYPE")
        dropList.selectedCode = self.selectedInvestorCode
        dropList.completion = {(selected: InvestorListModel?) -> Void in
            self.selectedInvestorCode = selected?.code
            self.investorTypeTextField.text = selected?.name
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionChoiceProjectPreference(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COProjectPreferenceDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("INVESTOR_PREFERENCE")
        dropList.selectedCode = self.selectedProjectCode
        dropList.completion = {(selected: ProjectListModel?) -> Void in
            self.selectedProjectCode = selected?.code
            self.projectPreferenceTextField.text = selected?.name
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionChoiceCurrency(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COCurrencyDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("INVESTOR_CURRENCY")
        dropList.selectedCode = self.selectedCurrencyCode
        dropList.completion = {(selected: CurrencyListModel?) -> Void in
            self.selectedCurrencyCode = selected?.code
            self.currencyTextField.text = selected?.name
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionBackVC(sender: AnyObject) {
        self.popToRootViewController(true)
    }
    
    @IBAction func actionDone(sender: AnyObject) {
        UIHelper.showLoadingInView()
        let userProfile = ProfileService()
        var body = userProfile.createParams()
        body[ServiceDefine.UserProfileInvestorField.investmentBudget] = investmentBudgetTextField.text!
        body[ServiceDefine.UserProfileInvestorField.duration] = durationPreferenceTextField.text!
        body[ServiceDefine.UserProfileInvestorField.target] = targetReturnTextField.text!
        body[ServiceDefine.UserProfileInvestorField.country] = countryPreferenceTextField.text!
        body[ServiceDefine.UserProfileInvestorField.descriptions] = descriptionTextField.text!
        body[ServiceDefine.UserProfileInvestorField.website] = websiteTextField.text!
        body[ServiceDefine.UserProfileInvestorField.CurrenceList] = userInvestProfile.getCodeForName(ServiceDefine.InvestorListType.TypeCurrency, name: currencyTextField.text!)
        body[ServiceDefine.UserProfileInvestorField.InvestorType] = userInvestProfile.getCodeForName(ServiceDefine.InvestorListType.TypeInvestor, name: investorTypeTextField.text!)
        body[ServiceDefine.UserProfileInvestorField.project] = userInvestProfile.getCodeForName(ServiceDefine.InvestorListType.TypeProject, name: projectPreferenceTextField.text!)
        userProfile.updateUserProfileInvestor(body) { (success, error) -> Void in
            UIHelper.hideLoadingFromView()
            if success == true && error == nil {
                self.popViewController()
            } else {
                UIHelper.showError(error, actionButton: nil)
            }
        }
    }
}
