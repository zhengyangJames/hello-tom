//
//  SettingViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, COSettingsStype) {
    COSettingsStypeContact,
    COSettingsStypeNew,
    COSettingsStypeCommentaries,
    COSettingsStypeTermOfUse,
    COSettingsStypeCodeOfConduct,
    COSettingsStypePrivacy,
    COSettingsStypeLogout
};

@interface SettingViewController : BaseViewController

@property (nonatomic, readonly) COSettingsStype coSettingsStype;

@end
