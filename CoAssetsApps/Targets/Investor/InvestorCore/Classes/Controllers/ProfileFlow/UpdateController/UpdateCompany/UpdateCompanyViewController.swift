//
//  UpdateCompanyViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire

class UpdateCompanyViewController: BaseViewController {
    //MARK: - Variable
    @IBOutlet weak private var orgAvatarImageView: UIImageView!
    @IBOutlet weak private var orgNameTextField: COTextFieldBottomLine!
    @IBOutlet weak private var orgTypeTextField: COTextFieldBottomLine!
    @IBOutlet weak private var address1TextField: COTextFieldBottomLine!
    @IBOutlet weak private var address2TextField: COTextFieldBottomLine!
    @IBOutlet weak private var cityTextField: COTextFieldBottomLine!
    @IBOutlet weak private var countryTextField: COTextFieldBottomLine!
    @IBOutlet weak private var bottomButton: CORedButton!
    
    private var imageURLocal: NSURL?
    
    var companyProfile: COCompanyProfileModel {
        return ProfileContainer.companyProfileModel
    }
    
    var companyService: CompanyService {
        return CompanyService()
    }
    
    var selectedOrgType: String?
    
    //MARK: - Override
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIForFields()
        updateUIForDevice()
        refreshUI()
        kApplication.statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        kApplication.statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setupUIForFields() {
        orgTypeTextField.isShowDropImage = true
        setTitleForFields()
    }
    
    func setTitleForFields() {
        orgNameTextField.title = m_local_string("OrgName")
        orgTypeTextField.title = m_local_string("OrgType")
        address1TextField.title = m_local_string("TITLE_ADDRESS1")
        address2TextField.title = m_local_string("TITLE_ADDRESS2")
        cityTextField.title = m_local_string("OrgCity")
        countryTextField.title = m_local_string("OrgCountry")
        bottomButton.setTitle(m_local_string("TITLE_DONE_UPDATE"), forState: .Normal)
    }
    
    //MARK: - Data
    private func refreshUI() {
        kMainQueue.addOperationWithBlock { () -> Void in
            let urlEncode = StringHelper.encodeCharacter(self.companyProfile.logoPath, characterEncode: " ")
            self.orgAvatarImageView.sd_setImageWithURL(NSURL(string: urlEncode))
            self.orgNameTextField.text = self.companyProfile.orgName
            self.orgTypeTextField.text = self.getNameForType(self.companyProfile.orgType)
            self.address1TextField.text = self.companyProfile.address1
            self.address2TextField.text = self.companyProfile.address2
            self.cityTextField.text = self.companyProfile.orgCity
            self.countryTextField.text = self.companyProfile.orgCountry
        }
    }
    
    private func getNameForType(type: String) -> String {
        let droplistCPM = COCompanyOrgTypeDropList()
        let arrayData = droplistCPM.companyOrgs.filter { $0.code == type.uppercaseString }
        if arrayData.isEmpty {
            return ""
        }
        return arrayData[0].name
    }
    
    private func getTypeForName(name: String) -> String {
        let droplistCPM = COCompanyOrgTypeDropList()
        let arrayData = droplistCPM.companyOrgs.filter { $0.name == name }
        if arrayData.isEmpty {
            return ""
        }
        return arrayData[0].code
    }
    
    private func showAlertView(message: String, textfield: UITextField) {
        self.view.endEditing(true)
        let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: message)
        alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (AlertAction) -> Void in
            textfield.becomeFirstResponder()
        }
        alert.show()
    }
    
    private func checkValidation() -> Bool {
        if orgNameTextField.text?.isEmpty == true {
            showAlertView(m_local_string("MESSAGE_FIRST_NAME"), textfield: orgNameTextField)
            return false
        }
        return true
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
            return NSLayoutConstraint(item: orgNameTextField,
                                      attribute: NSLayoutAttribute.Width,
                                      relatedBy: NSLayoutRelation.Equal,
                                      toItem: orgNameTextField,
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
        orgNameTextField.font = font
        orgTypeTextField.font = font
        cityTextField.font = font
        countryTextField.font = font
        address1TextField.font = font
        address2TextField.font = font
        cityTextField.font = font
    }
    
}

//MARK: - Actions
extension UpdateCompanyViewController {
    @IBAction func actionChoiceOrgType(sender: AnyObject) {
        view.endEditing(true)
        let dropList = COCompanyOrgTypeDropList.vc(CODropList.className)
        dropList.view.backgroundColor = UIColor.clearColor()
        dropList.titleDrop = m_local_string("APP_NAME")
        dropList.selectedOrgType = self.getTypeForName(self.orgTypeTextField.text!)
        dropList.completion = {(selected: CompanyOrgModel?) -> Void in
            self.selectedOrgType = selected?.code.uppercaseString
            self.orgTypeTextField.text = selected?.stringFormat()
        }
        self.presentViewController(dropList, animated: true, completion: nil)
    }
    
    @IBAction func actionPickImage(sender: AnyObject) {
        UIHelper.showActionSheetWithTitle(m_local_string("APP_NAME"),
            delegate: self,
            cancelTitle: m_local_string("TITLE_BUTTON_CANCEL"),
            destructTitle: nil,
            otherButtons: [m_local_string("TAKE_PHOTO_TITLE"), m_local_string("CHOOSE_EXISTING_TITLE")],
            tag: 100,
            controller: self)
    }
    
    @IBAction func actionBackVC(sender: AnyObject) {
        self.popToRootViewController(true)
    }
    
    @IBAction func actionDone(sender: AnyObject) {
        if checkValidation() {
            UIHelper.showLoadingInView()
            companyService.postCompanyProfile({ (multipartData) -> Void in
                self.creatMultipartFromDataCompany(multipartData)
            }) { (success, error) -> Void in
                UIHelper.hideLoadingFromView()
                if success == true && error == nil {
                    self.popViewController()
                } else {
                    UIHelper.showError(error, actionButton: nil)
                }
            }
        }
    }
    
    private func creatMultipartFromDataCompany(multipartFromData: MultipartFormData) {
        if let urlImage = imageURLocal {
            multipartFromData.appendBodyPart(fileURL: urlImage, name: ServiceDefine.CompanyProfileField.LogoUrl)
        }
        let dataOrgCity = UtilsHelper.creatDataFromValue(cityTextField.text)
        multipartFromData.appendBodyPart(data: dataOrgCity, name: ServiceDefine.CompanyProfileField.OrgCity)
        
        let dataOrgCountry = UtilsHelper.creatDataFromValue(countryTextField.text)
        multipartFromData.appendBodyPart(data: dataOrgCountry, name: ServiceDefine.CompanyProfileField.OrgCountry)
        
        let dataAddress1 = UtilsHelper.creatDataFromValue(address1TextField.text)
        multipartFromData.appendBodyPart(data: dataAddress1, name: ServiceDefine.CompanyProfileField.Address1)
        
        let dataAddress2 = UtilsHelper.creatDataFromValue(address2TextField.text)
        multipartFromData.appendBodyPart(data: dataAddress2, name: ServiceDefine.CompanyProfileField.Address2)
        
        let dataOrgName = UtilsHelper.creatDataFromValue(orgNameTextField.text)
        multipartFromData.appendBodyPart(data: dataOrgName, name: ServiceDefine.CompanyProfileField.OrgName)
        
        let dataOrgType = UtilsHelper.creatDataFromValue(self.selectedOrgType)
        multipartFromData.appendBodyPart(data: dataOrgType, name: ServiceDefine.CompanyProfileField.OrgType)
    }
}

//MARK: - ImagePicker
extension UpdateCompanyViewController {
    func showImagePickerControllerSourceTypeCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage as String]
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.presentViewController(picker, animated: true, completion: nil)
            })
        }
    }
    
    func showImagePickerControllerSourceTypePhotoLibrary() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.mediaTypes = [kUTTypeImage as String]
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.presentViewController(picker, animated: true, completion: nil)
            })
        }
    }
}


//MARK: - ImagePicker Delegate
extension UpdateCompanyViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let imageData = UIImagePNGRepresentation(image)
        let fileName = ResourcesHelper.createImageNameWithCurrentDate()
        let url = ResourcesHelper.publicDirectory().URLByAppendingPathComponent(fileName)
        if kFileManager.createFileAtPath(url.path!, contents: imageData, attributes: nil) {
            imageURLocal = url
        }
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.orgAvatarImageView.image = image
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

//MARK: - ActionsheetDelegate
extension UpdateCompanyViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        //Update Profile
        if actionSheet.tag == 100 {
            actionSheet.dismissWithClickedButtonIndex(buttonIndex, animated: true)
            if buttonIndex == 1 {
                // Camera
                showImagePickerControllerSourceTypeCamera()
            } else if buttonIndex == 2 {
                // Photo Library
                showImagePickerControllerSourceTypePhotoLibrary()
            }
        }
    }
}
