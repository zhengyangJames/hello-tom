//
//  COAccountInvestmentModel.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COAccountInvestmentModel.h"
#import "COUserPortFolioModel.h"
#import "COUserPortfolioOnGoingInvestmentModel.h"
#import "COUserPortfolioCompleteInvestmentModel.h"

@implementation COAccountInvestmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"ongoingInvestment"       : @"commit",
        @"fundedInvestment"        : @"funded_invested_amt",
        @"completedInvestment"     : @"completed_invested_amt",
        @"realisedPayouts"         : @"total_paid_payout",
        @"potentialPayouts"        : @"total_unpaid_payout",
        @"userPortfolio"           : @"portfolio",
    };
}

+ (NSValueTransformer *)userPortfolioJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserPortFolioModel.class];
}


- (NSString*)accOngoingTitle {
    return m_string(@"Ongoing Investment");
}

- (NSNumber*)accOngoingInvestment {
    return self.ongoingInvestment ;
}

- (NSString*)accFundedTitle {
    return m_string(@"Funded Investment");
}

- (NSNumber*)accFundedInvestment {
    return self.fundedInvestment ;
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

#pragma mark Portfolio

- (NSString*)OngoingProjectsImage {
    return @"ic_loadding";
}

- (NSString*)OngoingProjectsTitle {
    return @"Ongoing Projects";
}

- (NSNumber*)OngoingProjectsValue {
    COUserPortFolioModel *port = self.userPortfolio;
    return port.ongoingProjects;
}

- (NSString*)COOngoingInvestmentImage {
    return @"ic_money";
}

- (NSString*)COOngoingInvestmentTitle {
    return @"Ongoing Investment Amount";
}

- (NSNumber*)COOngoingInvestmentValue {
    COUserPortFolioModel *port = self.userPortfolio;
    COUserPortfolioOnGoingInvestmentModel *ongoing = port.ongoingInvestment;
    return ongoing.onGoingAmount;
}

- (NSString*)COCompletedProjectsImage {
    return @"ic_homes";
}

- (NSString*)COCompletedProjectsTitle {
    return @"Funded &Completed Projects";
}

- (NSNumber*)COCompletedProjectsValue {
    COUserPortFolioModel *port = self.userPortfolio;
    return port.fundedAndCompletedProjects;
}

- (NSString*)COCompletedInvestmentImage {
    return @"ic_Check_red";
}

- (NSString*)COCompletedInvestmentTitle {
    return @"Funded &Completed Investment Amount";
}

- (NSNumber*)COCompletedInvestmentValue {
    COUserPortFolioModel *port = self.userPortfolio;
    COUserPortfolioCompleteInvestmentModel *complete = port.fundedAndCompletedInvestment;
    return complete.completedAmount;
}

@end
