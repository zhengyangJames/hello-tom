//
//  AppDefines.h
//  CoAssest
//
//  Created by Macintosh HD on 6/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#ifndef CoAssest_AppDefines_h
#define CoAssest_AppDefines_h

#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "NSString+Validation.h"

///////////////////////////////////////////////////////////////////
#pragma mark - AppDefine
///////////////////////////////////////////////////////////////////

#define kAppDelegate                                (AppDelegate*)[UIApplication sharedApplication].delegate

///////////////////////////////////////////////////////////////////
#pragma mark - WSMAnager
///////////////////////////////////////////////////////////////////

#define METHOD_POST                                 @"POST"
#define METHOD_PUT                                  @"PUT"
#define METHOD_GET                                  @"GET"

#define WS_TIME_OUT                                 120
#define WS_ERROR_DOMAIN                             @"COASSETS_ERROR_DOMAIN"
//#define WS_ENDPOINT                                 @"https://www.coassets.com/api"
//#define WS_METHOD_POST_LOGIN                        @"https://www.coassets.com/oauth2/access_token/"
//#define CLIENT_ID                                   @"4c6a28b0137ff54909b3"
//#define CLIENT_SECRECT                              @"e88e20a9f9d642ed1e7e04ab0b72798b41455377"

#define WS_ENDPOINT                                 @"https://www.coassets.com/api"
#define WS_METHOD_POST_LOGIN                        @"https://www.coassets.com/o/token/"
#define CLIENT_ID                                   @"AoB2Dn2P93FFYkd2Hcd15opIaC9lIn8ciIPNg44O"
#define CLIENT_SECRECT @"E5SVOzDAICZ2fUJBx8uWFfb7eUZumkZ9QrSoCsLRgvAAQVEdMQ98TWyZdF07rQLbpX0sbJETOxsXJgoy2pUbpYlEQFnvHguPkFEH92fwHiAR2p6Yhxf1hwdTGkCruBKF"

#define WS_ACCESS_TOKEN                             @"dda346478c319db6faa474aace302858fe247e5c"
#define COREDATA_STORE_NAME                         @"CoAssest"
#define GRANT_TYPE                                  @"password"

#define kParseSDKAppID                                  @"mFlCjlgcR6hQ0vZosYkkj4lPDffwKbOsnLqONSUt"
#define kParseSDKClientID                               @"AbaaH9hpa5ABPPCBf5IJb6SBZuV1zcEKjrXwJQLe"
///////////////////////////////////////////////////////////////////
#pragma mark - WSMAnager - METHOD SERVICES
///////////////////////////////////////////////////////////////////
#define WS_METHOD_POST_PROGRESSBAR                  [WS_ENDPOINT stringByAppendingString:@"/project_fund_info/"]

#define WS_METHOD_POST_SUBSCRIBE                    [WS_ENDPOINT stringByAppendingString:@"/offers/subscribe/%@/"]

#define WS_METHOD_POST_QUESTION                     [WS_ENDPOINT stringByAppendingString:@"/offers/tellmemore/%@/"]

#define WS_METHOD_GET_LIST_OFFERS                   [WS_ENDPOINT stringByAppendingString:@"/offers"]

#define WS_METHOD_GET_LIST_CONTACT                  [WS_ENDPOINT stringByAppendingString:@"/company_info"]

#define WS_METHOD_POST_REGISTER                     [WS_ENDPOINT stringByAppendingString:@"/profile/register/"]

#define WS_METHOD_GET_LIST_PROFILE                  [WS_ENDPOINT stringByAppendingString:@"/profile/"]

#define WS_METHOD_POST_PORGOT_PASSWORD              [WS_ENDPOINT stringByAppendingString:@"/forget-password/"]

#define WS_METHOD_POST_CHANGE_PASSWORD              [WS_ENDPOINT stringByAppendingString:@"/change-password/"]

#define WS_METHOD_GET_ACCOUNT_INVESTER              [WS_ENDPOINT stringByAppendingString:@"/investment_dashboard/"]

#define WS_METHOD_GET_PROFILE_INVESTER              [WS_ENDPOINT stringByAppendingString:@"/investment_profile/"]
///////////////////////////////////////////////////////////////////
#pragma mark - Color defines
///////////////////////////////////////////////////////////////////
#define KNAV_BG_COLOR                               [UIColor colorWithRed:58/255.0f green:64/255.0f blue:70/255.0f alpha:1.0]

#define KBUTTON_COLOR                               [UIColor colorWithRed:231/255.0f green:75/255.0f blue:71/255.0f alpha:1.0]

#define KGREEN_COLOR                                [UIColor colorWithRed:0/255.0f green:200/255.0f blue:250/255.0f alpha:1.0]

#define KGRAY_COLOR                                 [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0]

#define KLIGHT_GRAY_COLOR                           [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0]
#define KBACKGROUND_COLOR                           [UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0]

///////////////////////////////////////////////////////////////////
#pragma mark - STRING
///////////////////////////////////////////////////////////////////
#define kPROFILE_JSON                               @"PROFILE_JSON"
#define kPROFILE_TOKEN_JSON                         @"PROFILE_TOKEN_JSON"
#define kPROFILE_OBJECT                             @"PROFILE_OBJECT"
#define kTOKEN_OBJECT                               @"token_object"
#define kUPDATE_PROFILE                             @"UpdateProfile"
#define kACCESS_TOKEN                               @"access_token"
#define kTOKEN_TYPE                                 @"token_type"
#define kCLIENT_ID                                  @"client_id"
#define kCLIENT_SECRECT                             @"client_secret"
#define kGRANT_TYPE                                 @"grant_type"
#define kUSER                                       @"username"
#define kPASSWORD                                   @"password"
#define KSALUTATION                                 @"salutation"
#define KFRIST_NAME                                 @"first_name"
#define KLAST_NAME                                  @"last_name"
#define KEMAIL                                      @"email"
#define KPHONE                                      @"phone"
#define KADDRESS                                    @"address_1"
#define KADDRESS2                                   @"address_2"
#define KORGNAME                                    @"orgname"
#define KIMAGE                                      @"image"
#define kNUM_COUNTRY                                @"country_prefix"
#define kNUM_CELL_PHONE                             @"cellphone"
#define KCITY                                       @"city"
#define KSATE                                       @"region_state"
#define KCOUNTRY                                    @"country"
#define kPROFILE                                    @"profile"
#define UPDATE_COMPANY_PROFILE_JSON                 @"Update profile copany"
#define UPDATE_INVESTOR_PROFILE_JSON                @"Update profile investor"
#define UPDATE_ACCOUNT_PROFILE_JSON                 @"Update profile account"
#define kUPDATE_VERSION                             @"Update_version_2.0"
////////////////////////////////////////////////////////////////
#pragma mark - KEY

#define kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL       6
#define kINDEX_SECTION_LOGO                         0
#define kINDEX_SECTION_OFFER_INFO                   1
#define kINDEX_SECTION_OFFER_DESCRIPTION            2
#define kINDEX_SECTION_PROJECT_DESCRIPTION          3
#define kINDEX_SECTION_DOCUMENT                     4
#define kCOUNT_ROW_FULL_INFO                        3
#define kCOUNT_ROW_NO_PROGRESS                      2
#define kDEFAULT_COUNT_OF_ROW                       1
#define kDEFAULT_NUMBER_ROW_DOC_DETAIL              2
#define kHEIGHT_FOR_ROW_DEFAULT_INFO                379
#define kHEIGHT_FOR_ROW_PROGRESS_INFO               64
#define kHEIGHT_FOR_ROW_ACTION_INFO                 115
#define kHEIGHT_FOR_ROW_TEXT                        85
#define kHEIGHT_FOR_ROW_DEFAULT                     44


#define kFILTER_BP                                  @"/BP"
#define kFILTER_CO                                  @"/CO"
#define kFILTER_PS                                  @"/PS"

#define kUSER_PROFILE_FILE_NAME                     @"UserProfile"

#define kNUMBERS_OF_ROW_OF_ABOUT                    6
#define kNUMBERS_OF_ROW_OF_CHANGE_PASS              2
////////////////////////////////////////////////////////////////
#pragma mark - WEB LINK

#define WEB_SAFARI_LINK                             @"http://coassets.com/terms-of-use/"
#define LINK_NEW                                    @"http://coassets.com/news/apps/"
#define LINK_TERMS_OF_USE                           @"http://www.coassets.com/apps/terms-of-use/"
#define LINK_CODE_OF_CONDUCT                        @"http://www.coassets.com/apps/code-of-conduct/"
#define LINK_PRIVACY                                @"http://www.coassets.com/apps/privacy/"
////////////////////////////////////////////////////////////////
#pragma mark - PROFILE DEFINE
#define DEFAULT_HEIGHT_CELL                         40
#define DEFAULT_HEIGHT_NO_DATA_CELL                 150
#define AUTO_HEIGHT_CELL_ABOUT                      (self.view.bounds.size.height - (200+90))/4
#define AUTO_HEIGHT_CELL_COMPANY                    (self.view.bounds.size.height - (200+90+44))
#define DEFAULT_HEIGHT_CELL_COMPANY                 205
#define AUTO_HEIGHT_CELL_PASSWORD                   (self.view.bounds.size.height - (200+90))
#define DEFAULT_HEIGHT_CELL_PASSWORD                171
#define HIEGHT_HEADERVIEW                           200
#define HIEGHT_BOTTOMVIEW                           70
#define DEFAULT_ADDRESS_CELL                         44
#define IS_IOS8_OR_ABOVE                            [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

#define HEIGHT_FOR_ROW_HOME                         248
#define HEIGHT_SECTION_CONTACT                      40
#define ESTIMATE_HEIGHT_FOR_ROW_CONTACT              185

#define HEIGHT_FOR_IMAGE_ROW                        220
#define NUM_OF_ROW_ABOUT                            8
#define NUM_OF_ROW_COMPANY                          4
#define NUM_OF_ROW_INVESTOR                         7

#define UPDATE_ABOUT_PROFILE                        @"Update profile"
#define UPDATE_COMNPANY_PROFILE                     @"Update company profile"

////////////////////////////////////////////////////////////////

#define KEY_TABBARSELECT                            @"KEY_TABBARSELECT"

#define KEY_VERSION                                 @"KEY_VERSION_SANYI"
#define KEY_BUILD_VERSION                                 @"KEY_BUILD_VERSION_SANYI"
////////////////////////////////////////////////////////////////
#pragma mark - Notification
////////////////////////////////////////////////////////////////

#define kNOTIFICATION_INTERESTED                    @"kNNOTIFICATION_INTERESTED"
#define kNOTIFICATION_QUESTION                      @"kNNOTIFICATION_QUESTION"
#define kNOTIFICATION_CHECK_PASS                    @"check_password"

#define MESSEAGE_RESET_PASSWORD                     @"Password Reset Successful We've e-mailed you instructions for setting your password to the e-mail address you submitted. You should be receiving it shortly"
#define DEFINE_HTML_FRAME                           @"<span style=\"font-family: 'Raleway-Light'; font-size: 15\">%@</span>"
//////////////////////////////////////////////////////////////
#pragma mark - enum
/////////////////////////////////////////////////////////////////

typedef NS_ENUM(NSInteger, COPortfolioProfile) {
    COPortfolioOngoingStype,
    COPortfolioInvesterStype,
    COPortfolioCompleteStype,
    COPortfolioFundedStype,
};

typedef NS_ENUM(NSInteger, COAccountInvestStype) {
    COAccountOngoingStype,
    COAccountFundedStype,
    COAccountCompleteStype,
    COAccountRealsStype,
    COAccountPotentialStype
};

typedef NS_ENUM(NSInteger, CODealsStype) {
    CODealsStypeOngoing,
    CODealsStypeFunded,
    CODealsStypeCompleted,
    CODealsStypeSuggest
};


typedef NS_ENUM(NSInteger, COSettingsStype) {
    COSettingsStypeContact,
    COSettingsStypeNew,
    COSettingsStypeTermOfUse,
    COSettingsStypeCodeOfConduct,
    COSettingsStypePrivacy,
    COSettingsStypeLogout
};

typedef NS_ENUM(NSInteger, COProfilesStype) {
    COProfilesStypeProfile,
    COProfilesStypeAccount,
    COProfilesStypePortfolio,
    COProfilesStypeDealsOngoing
};

typedef NS_ENUM(NSInteger, TableViewCellStyle) {
    TableViewCellStyleAbout,        //0
    //    TableViewCellStyleCompany,      //1
    TableViewCellStylePasswork      //2
};

typedef NS_ENUM(NSInteger, NProfileStyle) {
    NProfileStyleAbout = 0,
    NProfileStyleCompany,
    NProfileStyleInvestorProfile
};

typedef NS_ENUM(NSInteger, NProfileActionStyle) {
    NProfileActionUpdateProfile = 0,
    NProfileActionChangePassWord,
    NProfileActionUpdateCompany,
    NProfileActionUpdateInvestor
};

typedef NS_ENUM(NSInteger, COSegmentStyle) {
    COSegmentStyleAbout,        //0
    //    COSegmentStyleCompany,      //1
    COSegmentStylePasswork      //2
};

typedef NS_ENUM(NSInteger, COAboutProfileStyle) {
    COAboutProfileStyleUserName = 0,
    COAboutProfileStyleFirstName,
    COAboutProfileStyleLastNameSurname,
    COAboutProfileStyleEmail,
    COAboutProfileStylePhone,
    COAboutProfileStyleAddress
};

typedef NS_ENUM(NSInteger, COCompanyProfileStyle) {
    COCompanyProfileStyleImage = 0,
    COCompanyProfileStyleName,
    COCompanyProfileStyleAdress
};

typedef NS_ENUM(NSInteger, COInvedtorProfileStyle) {
    COInvedtorProfileStyleType = 0,
    COInvedtorProfileStylePreference,
    COInvedtorProfileStyleAmount,
    COInvedtorProfileStyleTarget,
    COInvedtorProfileStyleDuration,
    COInvedtorProfileStyleCountries
};

typedef NS_ENUM(NSInteger, LoginWithStyle){
    DismissLoginVC,
    PushLoginVC
};
typedef NS_ENUM(NSInteger, CODetailsProjectAction) {
    CODetailsProjectActionInterested,
    CODetailsProjectActionQuestions
};
#endif
