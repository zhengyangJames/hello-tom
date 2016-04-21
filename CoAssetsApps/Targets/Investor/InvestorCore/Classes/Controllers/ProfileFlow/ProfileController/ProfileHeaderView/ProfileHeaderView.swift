//
//  ProfileHeaderView.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

@objc
protocol ProfileHeaderViewDelegate: NSObjectProtocol {
    optional func headerView(view: ProfileHeaderView, actionUpdateProfile sender: UIButton) -> Void
    optional func headerView(view: ProfileHeaderView, actionUpdatePassword sender: UIButton) -> Void
}

let kProfileAvatar = "kProfileAvatar"
let kProfileFirstName = "kProfileFirstName"
let kProfileLastName = "kProfileLastName"
let kProfileCountry = "kProfileCountry"
let kProfileInvestor = "kProfileInvestor"
let kProfileCompany = "kProfileCompany"
let kProfileEmail = "kProfileEmail"
let kProfilePhone = "kProfilePhone"

class ProfileHeaderView: BaseView {
    
    @IBOutlet weak private var avatarImageVIew: COCircleImageView!
    @IBOutlet weak private var userNameLabel: BaseLabel!
    @IBOutlet weak private var countryLabel: BaseLabel!
    @IBOutlet weak private var investorLabel: BaseLabel!
    @IBOutlet weak private var companyLabel: BaseLabel!
    @IBOutlet weak private var emailLabel: BaseLabel!
    @IBOutlet weak private var phoneLabel: BaseLabel!
    @IBOutlet weak private var profileButton: BaseButton!
    @IBOutlet weak private var passwordButton: BaseButton!
    
    @IBOutlet weak private var lblCountryCT: NSLayoutConstraint!
    @IBOutlet weak private var lblInverCT: NSLayoutConstraint!
    @IBOutlet weak private var lblCompanyCT: NSLayoutConstraint!
    @IBOutlet weak private var lblEmailCT: NSLayoutConstraint!
    @IBOutlet weak private var lblPhoneCT: NSLayoutConstraint!
    
    var userProfile: COUserProfileModel {
        return ProfileContainer.userProfileModel
    }
    
    var companyProfile: COCompanyProfileModel {
        return ProfileContainer.companyProfileModel
    }
    
    var userInvestProfile: COInvestorProfileModel {
        return ProfileContainer.investorProfileModel
    }
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        profileButton.setTitle(m_local_string("TITLE_UPDATE_PROFILE"), forState: .Normal)
        passwordButton.setTitle(m_local_string("TITLE_UPDATE_PASSWORD"), forState: .Normal)
        setupProfileButton()
        setupPasswordButton()
    }
    
    private func setupProfileButton() {
        profileButton.layer.cornerRadius = 4
        profileButton.clipsToBounds = true
        profileButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        profileButton.backgroundColor = AppDefine.AppColor.CORedColor
    }
    
    private func setupPasswordButton() {
        passwordButton.layer.cornerRadius = 4
        passwordButton.layer.borderWidth = 1
        passwordButton.layer.borderColor = AppDefine.AppColor.CORedColor.CGColor
        passwordButton.clipsToBounds = true
        passwordButton.setTitleColor(AppDefine.AppColor.CORedColor, forState: .Normal)
        passwordButton.backgroundColor = UIColor.whiteColor()
    }
    
    func refreshUI() {
        if NSThread.isMainThread() {
            self._refreshUI()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self._refreshUI()
            }
        }
    }
    
    private func _refreshUI() {
        self.avatarImageVIew.image = UIImage(named: "portrait_ph.jpg")
        self.userNameLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirBlack, size: 18)
        self.userNameLabel.text = self.userProfile.firstName + " " + self.userProfile.lastName
        
        if self.userProfile.profile?.country?.isEmpty == true {
            self.countryLabel.text = ""
            lblCountryCT.constant = 0
        } else {
            self.countryLabel.text = self.userProfile.profile?.country
            lblCountryCT.constant = 18
        }
        
        if self.userInvestProfile.getNameForCode(ServiceDefine.InvestorListType.TypeInvestor).isEmpty == true {
            self.investorLabel.text = ""
            lblInverCT.constant = 0
        } else {
            self.investorLabel.text = self.userInvestProfile.getNameForCode(ServiceDefine.InvestorListType.TypeInvestor)
            lblInverCT.constant = 18
        }
        
        if self.companyProfile.orgName.isEmpty == true {
            self.companyLabel.text = ""
            lblCompanyCT.constant = 0
        } else {
            self.companyLabel.text = self.companyProfile.orgName
            lblCompanyCT.constant = 18
        }
        
        if self.userProfile.email.isEmpty == true {
            self.emailLabel.text = ""
            lblEmailCT.constant = 0
        } else {
            self.emailLabel.text = self.userProfile.email
            lblEmailCT.constant = 18
        }
        
        if self.userProfile.profile == nil {
            self.phoneLabel.text = ""
            lblPhoneCT.constant = 0
        } else {
            self.phoneLabel.text = "+\(self.userProfile.profile!.countryPrefix) \(self.userProfile.profile!.cellphone)"
            lblPhoneCT.constant = 18
        }
    }
    
    @IBAction func __actionUpdateProfile(sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.headerView?(self, actionUpdateProfile: sender)
        }
    }
    
    @IBAction func __actionUpdatePassword(sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.headerView?(self, actionUpdatePassword: sender)
        }
    }
    
    deinit {
        kNotification.removeObserver(self, name: AppDefine.NotificationKey.RevokedAccessToken, object: nil)
    }
}
