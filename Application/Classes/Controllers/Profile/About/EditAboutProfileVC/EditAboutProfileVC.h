//
//  EditAboutProfileVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ActionDoneAbout)(NSString* emailName,NSString* phone,NSInteger phoneCode,NSString* address);

@interface EditAboutProfileVC : BaseViewController

@property (strong, nonatomic) NSString *emailName;
@property (strong, nonatomic) NSString *phoneName;
@property (assign, nonatomic) NSInteger phoneCode;
@property (strong, nonatomic) NSString *addressName;
@property (copy, nonatomic) ActionDoneAbout actionDone;

@end
