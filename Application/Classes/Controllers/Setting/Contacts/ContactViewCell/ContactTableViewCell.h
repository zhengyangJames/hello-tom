//
//  ContactTableViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@class COContactsModel;

@interface ContactTableViewCell : BaseTableViewCell

@property (strong, nonatomic) COContactsModel *contactModel;

@end
