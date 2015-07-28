//
//  EditAboutProfileVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COListProfileObject.h"

@protocol EditAboutProfileVCDelegate;

@interface EditAboutProfileVC : BaseViewController

@property (strong, nonatomic) COListProfileObject *profileObject;
@property (strong, nonatomic) NSDictionary *dicProfile;
@property (weak, nonatomic) id<EditAboutProfileVCDelegate> delegate;

@end

@protocol EditAboutProfileVCDelegate <NSObject>

@optional
- (void)editAboutProfile:(EditAboutProfileVC*)editAboutProfileVC profileUpdate:(NSDictionary*)profileUpdate;

@end