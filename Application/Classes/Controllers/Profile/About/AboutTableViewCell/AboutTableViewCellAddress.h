//
//  AboutTableViewCellAddress.h
//  CoAssets
//
//  Created by TUONG DANG on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "COUserData.h"

@interface AboutTableViewCellAddress : BaseTableViewCell

@property (strong ,nonatomic) id<COUserAboutProfile> userAddress;

@end
