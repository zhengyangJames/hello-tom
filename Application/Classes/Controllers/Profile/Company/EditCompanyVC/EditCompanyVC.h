//
//  EditCompanyVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COBorderTextField.h"

typedef void(^ActionDone)(NSString *orgName,NSString* address,UIImage *imageCompany);

@interface EditCompanyVC : BaseViewController

@property (strong, nonatomic) NSString *orgName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) UIImage *imageName;
@property (copy, nonatomic) ActionDone actionDone;

@end