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
#define WS_ENDPOINT                                 @"https://www.coassets.com/api"

#define WS_ACCESS_TOKEN                             @"dda346478c319db6faa474aace302858fe247e5c"

#define COREDATA_STORE_NAME                         @"CoAssest"

#define CLIENT_ID                                   @"4c6a28b0137ff54909b3"
#define CLIENT_SECRECT                              @"e88e20a9f9d642ed1e7e04ab0b72798b41455377"
#define GRANT_TYPE                                  @"password"
///////////////////////////////////////////////////////////////////
#pragma mark - WSMAnager - METHOD SERVICES
///////////////////////////////////////////////////////////////////
#define WS_METHOD_POST_PROGRESSBAR                  [WS_ENDPOINT stringByAppendingString:@"/project_fund_info/"]

#define WS_METHOD_POST_SUBSCRIBE                    [WS_ENDPOINT stringByAppendingString:@"/offers/subscribe/"]

#define WS_METHOD_POST_QUESTION                     [WS_ENDPOINT stringByAppendingString:@"/offers/tellmemore/"]

#define WS_METHOD_GET_LIST_OFFERS                   [WS_ENDPOINT stringByAppendingString:@"/offers/"]

#define WS_METHOD_GET_LIST_CONTACT                  [WS_ENDPOINT stringByAppendingString:@"/company_info"]

#define WS_METHOD_POST_LOGIN                        @"https://www.coassets.com/oauth2/access_token/"

#define WS_METHOD_POST_REFISTER                     [WS_ENDPOINT stringByAppendingString:@"/profile/register/"]

#define WS_METHOD_GET_LIST_PROFIEL                  [WS_ENDPOINT stringByAppendingString:@"/profile/"]

#define WS_METHOD_POST_PORGOT_PASSWORD              [WS_ENDPOINT stringByAppendingString:@"/forget-password/"]

#define WS_METHOD_POST_CHANGE_PASSWORD              [WS_ENDPOINT stringByAppendingString:@"/change-password/"]
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
#define kPROFILE_OBJECT                             @"PROFILE_OBJECT"
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
#define KDEFAULT_LOGIN                              @"DefaultLogin"
#define KCITY                                       @"city"
#define KSATE                                       @"region_state"
#define KCOUNTRY                                    @"country"

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

////////////////////////////////////////////////////////////////
#pragma mark - WEB LINK

#define WEB_SAFARI_LINK                             @"http://coassets.com/terms-of-use/"

#define LINK_NEW                                    @"https://www.coassets.com/news/"
#define LINK_COMMENTARIES                           @"https://www.coassets.com/blog/"
#define LINK_TERMS_OF_USE                           @"https://www.coassets.com/terms-of-use/"
#define LINK_CODE_OF_CONDUCT                        @"https://www.coassets.com/code-of-conduct/"
#define LINK_PRIVACY                                @"https://www.coassets.com/privacy/"

////////////////////////////////////////////////////////////////

#define KEY_TABBARSELECT                            @"KEY_TABBARSELECT"

////////////////////////////////////////////////////////////////
#pragma mark - Notification
////////////////////////////////////////////////////////////////

#define kNOTIFICATION_INTERESTED                    @"kNNOTIFICATION_INTERESTED"
#define kNOTIFICATION_QUESTION                      @"kNNOTIFICATION_QUESTION"


#define DEFINE_HTML_FRAME                           @"<span style=\"font-family: 'Raleway-Light'; font-size: 15\">%@</span>"
#endif
