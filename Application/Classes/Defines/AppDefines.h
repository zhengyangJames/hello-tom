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
#pragma mark - Color defines
///////////////////////////////////////////////////////////////////
#define KNAV_BG_COLOR                       [UIColor colorWithRed:58/255.0f green:64/255.0f blue:70/255.0f alpha:1.0]

#define KBUTTON_COLOR                       [UIColor colorWithRed:231/255.0f green:75/255.0f blue:71/255.0f alpha:1.0]

#define KGREEN_COLOR                        [UIColor colorWithRed:0/255.0f green:200/255.0f blue:250/255.0f alpha:1.0]

#define KGRAY_COLOR                       [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0]

#define KLIGHT_GRAY_COLOR                 [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0]
#define KBACKGROUND_COLOR                 [UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0]
///////////////////////////////////////////////////////////////////
#pragma mark - STRING
///////////////////////////////////////////////////////////////////
#define KSALUTATION @"salutation"
#define KFRIST_NAME @"firstname"
#define KLAST_NAME  @"lastnameurname"
#define KEMAIL      @"email"
#define KPHONE      @"phone"
#define KADDRESS    @"address"
#define KORGNAME    @"orgname"
#define KIMAGE      @"image"

#endif
