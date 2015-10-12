//
//  EditCompanyVC.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COUserCompanyModel.h"

typedef void(^ActionDone)(CGFloat updateForCellImage);

@interface EditCompanyVC : BaseViewController

@property (copy, nonatomic) ActionDone actionDone;

@property (strong, nonatomic) COUserCompanyModel *companyUserModel;

@end
