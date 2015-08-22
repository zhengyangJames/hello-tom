//
//  AboutTableViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "COUserData.h"

@interface AboutTableViewCell : BaseTableViewCell

@property (nonatomic, strong) id<COUserFirstName> userFirstName;
@property (nonatomic, strong) id<COUserLastName> userLastName;
@property (nonatomic, strong) id<COUserEmail> userEmail;
@property (nonatomic, strong) id<COUserPhone> userPhone;
@end
