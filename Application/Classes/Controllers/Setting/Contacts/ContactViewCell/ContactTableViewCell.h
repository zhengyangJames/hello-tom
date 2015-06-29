//
//  ContactTableViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "COListContactObject.h"

@interface ContactTableViewCell : BaseTableViewCell

@property (strong, nonatomic) COListContactObject *contactObj;

@end
