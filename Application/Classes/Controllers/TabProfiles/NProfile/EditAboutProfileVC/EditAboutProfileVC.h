//
//  EditAboutProfileVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COUserData.h"

@class COUserProfileModel;

@protocol EditAboutProfileVCDelegate;

@interface EditAboutProfileVC : BaseViewController

@property (weak, nonatomic) id<EditAboutProfileVCDelegate> delegate;
@property (strong, nonatomic) COUserProfileModel *aboutUserModel;

@end

@protocol EditAboutProfileVCDelegate <NSObject>

@optional
- (void)editAboutProfile:(EditAboutProfileVC*)editAboutProfileVC;

@end