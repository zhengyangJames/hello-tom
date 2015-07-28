//
//  ProfileViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, TableViewCellStyle) {
    TableViewCellStyleAbout,        //0
//    TableViewCellStyleCompany,      //1
    TableViewCellStylePasswork      //2
};

typedef NS_ENUM(NSInteger, COSegmentStyle) {
    COSegmentStyleAbout,        //0
//    COSegmentStyleCompany,      //1
    COSegmentStylePasswork      //2
};

typedef NS_ENUM(NSInteger, COAboutProfileStyle) {
    COAboutProfileStyleFirstName,
    COAboutProfileStyleLastNameSurname,
    COAboutProfileStyleEmail,
    COAboutProfileStylePhone,
    COAboutProfileStyleAddress
};

@interface ProfileViewController : BaseViewController

@end
