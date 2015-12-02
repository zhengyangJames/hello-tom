//
//  NProfileAdressCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUserData.h"

@interface NProfileAdressCell : UITableViewCell
@property (strong ,nonatomic) id<COUserAboutProfile> userAddress;
@property (strong ,nonatomic) id<COCompanyAdress> userAddressCompany;
@property (strong ,nonatomic) id<COInvestorCountries> userAddressInvestor;
@end
