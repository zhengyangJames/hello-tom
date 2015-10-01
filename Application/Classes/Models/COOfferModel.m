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
    return NSLocalizedString(@"OFFER", nil);
}

- (NSString *)offerDescriptionContent {
    return [UIHelper _getStringFromHtml:self.offerShortDescription].string;
}

#pragma mark - offer project protocol

- (NSString *)offerProjectTitle {
    return NSLocalizedString(@"PROJECT", nil);
}
- (NSString *)offerProjectContent {
    return self.offerProjectDescription;
}
#pragma mark - offer document protocol

- (NSString *)offerDocumentTitle {
    return NSLocalizedString(@"DOCUMENT", nil);
}

- (NSString *)offerDocumentContent {
    return NSLocalizedString(@"DETAIL_DOCUMENT", nil);
}
#pragma mark - offer info protocol

- (NSString *)offerInfoStatus {
    if (self.offerStatus) {
        NSString *status = [NSString stringWithFormat:NSLocalizedString(@"STATUS", nil),self.offerStatus];
        return status;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoInvestor {
    if (self.offerInvestorCount) {
        NSString *investor = [NSString stringWithFormat:NSLocalizedString(@"INVESTORS", nil),self.offerInvestorCount];
        return investor;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoMinInvesment {
    if (self.offerMinInvestment) {
        double number = [self.offerMinInvestment doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringDecimalFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoTimeHorizon {
    if (self.offerTimeHorizon) {
        NSString *time_horizon = [NSString stringWithFormat:NSLocalizedString(@"MONTHS", nil),self.offerTimeHorizon];        return time_horizon;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoYield {
    if (self.offerAnnualizedReturn) {
        NSString *annualized = [NSString stringWithFormat:NSLocalizedString(@"MIN_ANNUAL_RETURN", nil),self.offerAnnualizedReturn,self.offerAnnualizedReturn];
        return annualized;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoDayLeft {
    if (self.offerDayLeft) {
        NSString *day_left = [NSString stringWithFormat:NSLocalizedString(@"DAY_LEFT", nil),self.offerDayLeft];
        return day_left;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}
@end
