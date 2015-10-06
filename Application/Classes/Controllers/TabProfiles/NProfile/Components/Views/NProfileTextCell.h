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

@property (nonatomic, strong) id<COUserName> userName;
@property (nonatomic, strong) id<COUserFirstName> userFirstName;
@property (nonatomic, strong) id<COUserLastName> userLastName;
@property (nonatomic, strong) id<COUserEmail> userEmail;
@property (nonatomic, strong) id<COUserPhone> userPhone;

@property (nonatomic, strong) id<COCompanyName> companytName;

@property (nonatomic, strong) id<COInvestorType> investorType;
@property (nonatomic, strong) id<COInvestorPreference> investorPreference;
@property (nonatomic, strong) id<COInvestorAmount> investorAmount;
@property (nonatomic, strong) id<COInvestorTarget> investorTarget;
@property (nonatomic, strong) id<COInvestorDuration> investorDuration;
@property (nonatomic, strong) id<COInvestorCountries> investorCountries;

@end
