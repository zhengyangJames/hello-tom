//
//  CODetailsProfileObj+Formater.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/11/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProfileObj.h"

@interface CODetailsProfileObj (Formater)

- (NSString *)stringOfInvestorCount;
- (NSString *)stringOfStatus;
- (NSString *)stringOfMinAnnualReturn;
- (NSString *)currencyStringFormatFromInvestment;
- (NSString *)stringOfDayLeft;
- (NSString *)stringOfTimeHorizon;

@end
