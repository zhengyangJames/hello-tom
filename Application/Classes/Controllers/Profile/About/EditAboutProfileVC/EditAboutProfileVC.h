//
//  EditAboutProfileVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COListProfileObject.h"

typedef void(^ActionDoneAbout)(NSDictionary* profile);

@interface EditAboutProfileVC : BaseViewController

@property (strong, nonatomic) COListProfileObject *profileObject;
@property (strong, nonatomic) NSDictionary *dicProfile;
@property (copy, nonatomic) ActionDoneAbout actionDone;

@end
