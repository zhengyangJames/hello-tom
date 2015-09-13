//
//  COProgressbarObj+Formatter.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/11/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProgressbarObj.h"

@interface COProgressbarObj (Formatter)

- (NSString *)stringOfGoal;
- (NSString *)currencyStringFormatFromCurrentFundedAmount;
- (NSString *)stringOfTotalCurrency;
@end
