//
//  EditAboutProfileVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COListProfileObject.h"

typedef void(^ActionDoneAbout)(NSString* emailName,NSString* phone,NSString *phoneCode,NSString* address,NSString* addressName2,NSString* city,NSString* country,NSString* state);

@interface EditAboutProfileVC : BaseViewController

@property (strong, nonatomic) NSString *emailName;
@property (strong, nonatomic) NSString *phoneName;
@property (assign, nonatomic) NSString *phoneCode;
@property (strong, nonatomic) NSString *addressName;
@property (strong, nonatomic) NSString *addressName2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) COListProfileObject *profileObject;
@property (copy, nonatomic) ActionDoneAbout actionDone;

@end
