//
//  COOfferModel.h
//  CoAssets
//
//  Created by Linh NGUYEN on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COOfferData.h"

@class COProjectModel;

@interface COOfferModel : MTLModel<MTLJSONSerializing, COOfferLogo,COOfferInfo,COOfferDescription,COOfferProject,COOfferDocument,COHomeOffer,COInterestedAction>

@property (nonatomic, strong) NSNumber *offerId;
@property (nonatomic, strong) NSString *offerTitle;
@property (nonatomic, strong) NSString *offerType;
@property (nonatomic, strong) COProjectModel *offerProject;
@property (nonatomic, strong) NSString *offerOwnerType;
@property (nonatomic, strong) NSString *offerCompanyLogo;
@property (nonatomic, strong) NSString *offerCurrency;
@property (nonatomic, strong) NSString *offerStatus;
@property (nonatomic, strong) NSNumber *offerInvestorCount;
@property (nonatomic, strong) NSNumber *offerMinInvestment;
@property (nonatomic, strong) NSNumber *offerTimeHorizon;
@property (nonatomic, strong) NSString *offerAnnualizedReturn;
@property (nonatomic, strong) NSString *offerAnnualReturn;
@property (nonatomic, strong) NSNumber *offerDayLeft;
@property (nonatomic, strong) NSString *offerShortDescription;
@property (nonatomic, strong) NSString *offerProjectDescription;
@property (nonatomic, strong) NSArray *documents;

- (NSNumber *)numberOfOfferId;
- (NSArray *)arrayDocuments;
- (NSString *)contentProjectWeb;
@end
