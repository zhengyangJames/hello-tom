//
//  AccountCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COAccountInvestmentModel.h"

@interface AccountCell : UITableViewCell

@property (strong, nonatomic) id<COAccountOnGoing> accountOnGoing;
@property (strong, nonatomic) id<COAccountFunded> accountFunded;
@property (strong, nonatomic) id<COAccountCompleted> accountCompleted;
@property (strong, nonatomic) id<COAccountRealised> accountRealised;
@property (strong, nonatomic) id<COAccountPotential> accountPotential;

@end
