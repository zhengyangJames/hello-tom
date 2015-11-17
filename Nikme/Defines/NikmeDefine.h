//
//  NikmeDefine.h
//  NikmeCamera
//
//  Created by Linh NGUYEN on 10/22/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#ifndef NikmeCamera_NikmeDefine_h
#define NikmeCamera_NikmeDefine_h


///////////////////////////////////////////////////////////////////
// Import Defines
///////////////////////////////////////////////////////////////////

#import "UIView+Autolayout.h"
#import "UIView+Identifier.h"
#import "NMUIHelper.h"
#import "NSFileManager+Directories.h"
#import "NSString+Helpers.h"
#import "NSDictionary+NotNULL.h"

///////////////////////////////////////////////////////////////////
// Common Defines
///////////////////////////////////////////////////////////////////

#define IS_IPHONE                               ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_6PLUS                         ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

#define IS_IPHONE_6                             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)

#define IS_IPHONE_5                             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)

#define IS_IPHONE_4                             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)

#define kUserDefaults                           [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                     [NSNotificationCenter defaultCenter]
#define kFileManager                            [NSFileManager defaultManager]

///////////////////////////////////////////////////////////////////
// UserDefault Defines
///////////////////////////////////////////////////////////////////
#define kPREF_FIRST_RUN                         @"kPREF_FIRST_RUN"

#define kPREF_PUSH_TOKEN                        @"kPREF_PUSH_TOKEN"
#define kPREF_REGISTERED_TOKEN                  @"kPREF_REGISTERED_TOKEN"

///////////////////////////////////////////////////////////////////
// Multi-Language Defines
///////////////////////////////////////////////////////////////////

#define m_string(str)                           (NSLocalizedString(str, nil))

#endif
///////////////////////////////////////////////////////////////////
// By Vincent
///////////////////////////////////////////////////////////////////
#define NOTIFICATION_ID                       @"NotificationID"