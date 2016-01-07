//
//  COOfferModel.m
//  CoAssets
//
//  Created by Linh NGUYEN on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferModel.h"
#import "COProjectModel.h"
#import "CODocumentModel.h"
#import "MTLValueTransformer.h"
#import "COProjectFundedAmountModel.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"

@implementation COOfferModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"offerId"                  : @"id",
        @"offerTitle"               : @"offer_title",
        @"offerType"                : @"offer_type",
        @"offerProject"             : @"project",
        @"offerOwnerType"           : @"owner_type",
        @"offerCompanyLogo"         : @"company_logo",
        @"offerCurrency"            : @"currency",
        @"offerStatus"              : @"status",
        @"offerInvestorCount"       : @"investor_count",
        @"offerMinInvestment"       : @"min_investment",
        @"offerTimeHorizon"         : @"time_horizon",
        @"offerAnnualizedReturn"    : @"annualized_return",
        @"offerDayLeft"             : @"day_left",
        @"offerShortDescription"    : @"short_description",
        @"offerProjectDescription"  : @"project_description",
        @"documents"                : @"documents",
        
    };
}

+ (NSValueTransformer *)offerProjectJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COProjectModel.class];
}

+ (NSValueTransformer *)documentsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableArray *array;
        if (value) {
            NSDictionary *dict = (NSDictionary*)value;
            array = [[NSMutableArray alloc] init];
            for (NSString *key in dict.allKeys) {
                NSArray *items = [dict objectForKey:key];
                NSDictionary *documentDict = @{@"title":key, @"items":items};
                [array addObject:documentDict];
            }
        }
        *success = YES;
        return [MTLJSONAdapter modelsOfClass:[CODocumentModel class] fromJSONArray:array error:error];
    }];
}

- (NSString *)contentProjectWeb {
    return self.offerProjectDescription;
}

- (NSArray *)arrayDocuments {
    return self.documents;
}

- (NSNumber *)numberOfOfferId {
    return self.offerId;
}
#pragma mark - home protocol

- (NSString *)homeOfferCompanyPhoto {
    COProjectModel *proModel = self.offerProject;
    return proModel.projectPhoto;
}

- (NSString *)homeOfferCountry {
    COProjectModel *proModel = self.offerProject;
    return proModel.projectCountry;
}

- (NSString *)homeOfferTitle {
    return self.offerTitle;
}

- (NSNumber *)homeOfferID {
    return self.offerId;
}

- (NSString *)homeOfferType {
    return self.offerType;
}

#pragma mark - interested action

- (NSNumber *)numberIdOfOffer {
    return self.offerId;
}

- (NSString *)stringOfOfferTitle {
    return self.offerTitle;
}

- (NSNumber *)numberOfOfferAmount {
    return self.offerMinInvestment;
}

- (NSString *)stringOfUserEmail {
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    if (userModel) {
        return userModel.stringOfProfileEmail;
    }
    return @"";
}
#pragma mark - logo protocol

- (NSString *)offerLogoImage {
    return self.offerCompanyLogo;
}

- (NSString *)offerLogoTitle {
    return self.offerTitle;
}

#pragma mark - offer description protocol

- (NSString *)offerDescriptionTitle {
    return m_string(@"OFFER");
}

- (NSString *)offerDescriptionContent {
    return [UIHelper _getStringFromHtml:self.offerShortDescription].string;
}

#pragma mark - offer project protocol

- (NSString *)offerProjectTitle {
    return m_string(@"PROJECT");
}
- (NSString *)offerProjectContent {
    return self.offerProjectDescription;
}
#pragma mark - offer document protocol

- (NSString *)offerDocumentTitle {
    return m_string(@"DOCUMENT");
}

- (NSString *)offerDocumentContent {
    return m_string(@"DETAIL_DOCUMENT");
}
#pragma mark - offer info protocol

- (NSString *)offerInfoCurrency {
    DBG(@"%@",self.offerCurrency);
    if (self.offerCurrency) {
        NSString *currency = [UIHelper getStringCurrencyOfferWithKey:self.offerCurrency];
        return currency;
    } else {
        return m_string(@"N/A");
    }
}


- (NSString *)offerInfoStatus {
    if (self.offerStatus) {
        NSString *status = [NSString stringWithFormat:m_string(@"STATUS"),self.offerStatus];
        return status;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)offerInfoInvestor {
    if (self.offerInvestorCount) {
        NSString *investor = [NSString stringWithFormat:m_string(@"INVESTORS"),self.offerInvestorCount];
        return investor;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)offerInfoMinInvesment {
    if (self.offerMinInvestment) {
        double number = [self.offerMinInvestment doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringDecimalFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)offerInfoTimeHorizon {
    if (self.offerTimeHorizon) {
        NSString *time_horizon = [NSString stringWithFormat:m_string(@"MONTHS"),self.offerTimeHorizon];        return time_horizon;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)offerInfoYield {
    if (self.offerAnnualizedReturn) {
        NSString *annualized = [NSString stringWithFormat:m_string(@"MIN_ANNUAL_RETURN"),self.offerAnnualizedReturn,self.offerAnnualizedReturn];
        return annualized;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)offerInfoDayLeft {
    if (self.offerDayLeft) {
        NSString *day_left = [NSString stringWithFormat:m_string(@"DAY_LEFT"),self.offerDayLeft];
        return day_left;
    } else {
        return m_string(@"N/A");
    }
}
@end
