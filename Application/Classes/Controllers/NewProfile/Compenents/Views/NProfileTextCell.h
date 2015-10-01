//
//  NProfileTextCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUserData.h"

@interface NProfileTextCell : UITableViewCell

@property (nonatomic, strong) id<COUserFirstName> userFirstName;
@property (nonatomic, strong) id<COUserLastName> userLastName;
@property (nonatomic, strong) id<COUserEmail> userEmail;
@property (nonatomic, strong) id<COUserPhone> userPhone;

@property (nonatomic, strong) id<COCompanyName> compantName;
@property (nonatomic, strong) id<COCompanyAdress> companyAdress;

@end
