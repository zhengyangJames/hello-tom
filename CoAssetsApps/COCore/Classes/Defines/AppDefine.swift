//
//  AppDefine.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

struct AppDefine {
    
}

//MARK: UserDefaultKey
extension AppDefine {
    struct UserDefaultKey {
        static let LoggedIn                 = "LoggedIn"
        static let COAccessToken            = "COAccessToken"
        static let CODeviceToken            = "CODeviceToken"
        static let COTypeToken              = "COTypeToken"
        static let CORefreshToken           = "CORefreshToken"
        static let COSentDeviceToken        = "COSentDeviceToken"
        static let UserProfileModel         = "UserProfileModel"
        static let CompanyProfileModel      = "CompanyProfileModel"
        static let InvestorProfileModel     = "InvestorProfileModel"
        static let InvestmentDashboardModel = "InvestmentDashboardModel"
        static let StockProfileModel        = "StockProfileModel"
        static let NotificationModel        = "NotificationModel"
    }
}

//MARK: Notification
extension AppDefine {
    struct NotificationKey {
        static let RevokedAccessToken       = "RevokedAccessToken"
        static let GrantedAccessToken       = "GrantedAccessToken"
        static let LoggedIn                 = "LoggedIn"
    }
}

//MARK: - Screensize
extension AppDefine {
    struct ScreenSize {
        static let ScreenWidth              = UIScreen.mainScreen().bounds.size.width
        static let ScreenHeight             = UIScreen.mainScreen().bounds.size.height
        static let ScreenMaxLength          = max(ScreenSize.ScreenWidth, ScreenSize.ScreenHeight)
        static let ScreenMinLength          = min(ScreenSize.ScreenWidth, ScreenSize.ScreenHeight)
        static let ScreenScale              = (ScreenSize.ScreenWidth / 375.0) < 0.9 ? 0.9 : ((ScreenSize.ScreenWidth / 375.0) > 1.3 ? 1.3 : ScreenSize.ScreenWidth / 375.0)
        static let Navigation               = 64.0
    }
}

//MARK: - DeviceType
extension AppDefine {
    struct DeviceType {
        static let IsIphone4orLess  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && AppDefine.ScreenSize.ScreenMaxLength < 568.0
        static let IsIphone5        = UIDevice.currentDevice().userInterfaceIdiom == .Phone && AppDefine.ScreenSize.ScreenMaxLength == 568.0
        static let IsIphone6        = UIDevice.currentDevice().userInterfaceIdiom == .Phone && AppDefine.ScreenSize.ScreenMaxLength == 667.0
        static let IsIphone6P       = UIDevice.currentDevice().userInterfaceIdiom == .Phone && AppDefine.ScreenSize.ScreenMaxLength == 736.0
        static let IsIPpad          = UIDevice.currentDevice().userInterfaceIdiom == .Pad && AppDefine.ScreenSize.ScreenMaxLength == 1024.0
        
    }
}
//MARK: - Color
extension AppDefine {
    struct AppColor {
        static let COBlackColor         = UIColor(red: 29.0/255, green: 29.0/255, blue: 38.0/255, alpha: 1.0)
        static let COWhiteColor         = UIColor.whiteColor()
        static let COGrayColo           = UIColor.grayColor()
        static let CORedColor           = UIColor(red: 226.0/255, green: 52.0/255, blue: 40.0/255, alpha: 1.0)
        static let COGrayWhiteColor     = UIColor(red: 208.0/255, green: 208.0/255, blue: 208.0/255, alpha: 0.5)
        static let COGrayColor          = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        static let CORedRimColor        = UIColor(red: 254.0/255, green: 177.0/255, blue: 173.0/255, alpha: 0.8)
        static let COGreenRimColor      = UIColor(red: 169.0/255, green: 218.0/255, blue: 163.0/255, alpha: 0.8)
        static let COCurrentColor       = UIColor(red: 241.0/255, green: 241.0/255, blue: 241.0/255, alpha: 1)
        static let COblueColor          = UIColor(red: 240.0/255, green: 255.0/255, blue: 248.0/255, alpha: 1)
        static let CORedAlphaColor      = UIColor(red: 214.0/255, green: 0, blue: 0, alpha: 0.2)
        static let COYellowAlphaColor   = UIColor(red: 227.0/255, green: 181.0/255, blue: 11.0/255, alpha: 0.2)
        static let COBlueAlphaColor     = UIColor(red: 9.0/255, green: 69.0/255, blue: 206.0/255, alpha: 0.2)
        static let COGrayColorGray      = UIColor(red: 236.0/255, green: 236.0/255, blue: 236.0/255, alpha: 1)
        static let COGrayColorText      = UIColor(red: 43.0/255, green: 43.0/255, blue: 43.0/255, alpha: 1)
        
        static let CORedListColor       = UIColor(red: 220.0/255, green: 35.0/255, blue: 31.0/255, alpha: 1)
        static let COYellowListColor    = UIColor(red: 252.0/255, green: 202.0/255, blue: 22.0/255, alpha: 1)
        static let COBlueListColor      = UIColor(red: 79.0/255, green: 112.0/255, blue: 220.0/255, alpha: 1)
        static let CORedHighlightColor  = UIColor(red: 215.0/255, green: 30.0/255, blue: 31.0/255, alpha: 1)
        static let COBlueTextContact    = UIColor(red: 0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        static let COGrayBackGroundContact    = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let COOrangeColor       = UIColor.orangeColor()
        static let COLightYellow      = UIColor(red: 255.0/255, green: 255.0/255, blue: 102.0/255, alpha: 1)
    }
}

//MARK: - Font
extension AppDefine {
    struct AppFontName {
        static let COHelveticaNeueFontName = "Helvetica Neue"
        static let COAvenir = "Avenir"
        static let COAvenirBlack = "Avenir-Black"
        static let COAvenirRoman = "Avenir-Roman"
        static let COAvenirBook = "Avenir-Book"
        static let COAvenirMedium = "Avenir-Medium"
        static let COAvenirLight = "Avenir-Light"
    }
}

//MARK: - Enum
extension AppDefine {
    struct AppEnum {
        
        enum ManageInvestmentType: Int {
            case ProjectListPage = 0
            case FAQPage         = 1
            case ClientPage      = 2
            case InvestmentPage  = 3
        }
        
        enum InvestmentPageSectionType: Int {
            case Client          = 0
            case Investment      = 1
        }
        
        enum OverviewType: Int {
            case OverviewAddress        = 0
            case OverviewDescription    = 1
        }
        
        enum FAQPageType: Int {
            case Normal = 0
            case Drop   = 1
        }
        
        enum FontType: String {
            case COAvenir
            case COAvenirBlack
            case COAvenirRoman
            case COAvenirBook
            case COAvenirMedium
        }
        
        enum ProjectListType: Int {
            case ProjectListHighligh    = 0
            case ProjectListProject     = 1
            case ProjectListPriceRangge = 2
        }
        
        enum ProjectList: String {
            case ProjectListBulk            = "Bulk Purchase"
            case ProjectListCroudFunding    = "Crowdfunding"
            case ProjectListPresale         = "Pre-Sales"
        }
        
        enum COSettingsStype: NSInteger {
            case COSettingsStypeContact       = 0
            case COSettingsStypeNew           = 1
            case COSettingsStypeTermOfUse     = 2
            case COSettingsStypeCodeOfConduct = 3
            case COSettingsStypePrivacy       = 4
            case COSettingsStypeLogout       = 5
        }
    }
}
//MARK: FAQArray

extension AppDefine {
    enum PortfolioSection: Int {
        case Portfolio           = 0
        case Completed           = 1
        case AvailableBalance    = 2
        case Form                = 3

    }
}

//MARK: FAQArray

extension AppDefine {
    struct FAQStruct {
        var isShow: Bool
        var title: String?
        var type: AppDefine.AppEnum.FAQPageType?
        
        init(title: String?, type: AppDefine.AppEnum.FAQPageType?, show: Bool = false) {
            self.isShow = show
            self.title = title
            self.type = type
        }
    }
}

//MARK: Formatter

extension AppDefine {
    struct DateFormat {
        static let Notification             = "yyyy-MM-dd HH:mm:ssZ"
        static let Common                   = "dd-MM-yyyy"
    }
}
