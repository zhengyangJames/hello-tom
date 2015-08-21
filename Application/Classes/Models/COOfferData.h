//
//  COOfferData.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COHomeOffer <NSObject>

- (NSString *)homeOfferCompanyPhoto;
- (NSString *)homeOfferCountry;
- (NSString *)homeOfferTitle;
- (NSNumber *)homeOfferID;
- (NSString *)homeOfferType;

@end

@protocol COOfferLogo <NSObject>

- (NSString *)offerLogoImage;
- (NSString *)offerLogoTitle;
@end

@protocol COOfferInfo <NSObject>

- (NSString *)offerInfoStatus;
- (NSString *)offerInfoInvestor;
- (NSString *)offerInfoMinInvesment;
- (NSString *)offerInfoTimeHorizon;
- (NSString *)offerInfoYield;
- (NSString *)offerInfoDayLeft;
@end

@protocol COOfferDescription <NSObject>

- (NSString *)offerDescriptionTitle;
- (NSString *)offerDescriptionContent;
@end

@protocol COOfferProject <NSObject>

- (NSString *)offerProjectTitle;
- (NSString *)offerProjectContent;
@end

@protocol COOfferDocument <NSObject>

- (NSString *)offerDocumentTitle;
- (NSString *)offerDocumentContent;
@end

@protocol COOfferAddress <NSObject>

- (NSString *)offerAddressTitle;
- (NSString *)offerAddressContent;
@end

@protocol COOfferDocumentDetail <NSObject>

- (NSString *)offerDocumentDetailTitle;
- (NSArray *)offerDocumentDetailContent;
@end

@protocol COProjectFundedAmount <NSObject>

- (NSString *)offerInfoGoalToString;
- (NSString *)currentFundedAmountToString;
- (NSString *)totalProgress;
- (NSNumber *)goalOrigin;
@end

@protocol CODocumentItem <NSObject>

- (NSString *)itemTitle;
- (NSString *)itemUrl;
@end
