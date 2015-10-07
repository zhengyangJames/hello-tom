//
//  COAccountInvestmentModel.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COAccountInvestmentModel.h"

@implementation COAccountInvestmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"ongoingInvestment"       : @"commit",
        @"fundedInvestment"        : @"funded_invested_amt",
        @"completedInvestment"     : @"completed_invested_amt",
        @"realisedPayouts"         : @"total_paid_payout",
        @"potentialPayouts"        : @"total_unpaid_payout",
    };
}

- (NSString*)accOngoingTitle {
    return m_string(@"Ongoing Investment");
}

- (NSNumber*)accOngoingInvestment {
    return self.ongoingInvestment;
}

- (NSString*)accFundedTitle {
    return m_string(@"Funded Investment");
}

- (NSNumber*)accFundedInvestment {
    return self.fundedInvestment;
}

- (NSString*)accCompletedtitle {
    return m_string(@"Completed Investment");
}

- (NSNumber*)accCompletedInvestment {
    return self.completedInvestment;
}

- (NSString*)accRealisedTitle {
    return m_string(@"Realised Payouts");
}

- (NSNumber*)accRealisedPayouts {
    return self.realisedPayouts;
}

- (NSString*)accPotentialTitle {
    return m_string(@"Potential Payouts");
}

- (NSNumber*)accPotentialPayouts {
    return self.potentialPayouts;
}

@end
