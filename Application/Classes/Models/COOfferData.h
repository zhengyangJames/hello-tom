//
//  COOfferData.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (NSString *)offerInfoGoalToString;
- (NSString *)currentFundedAmountToString;
- (NSString *)totalProgress;
- (NSNumber *)goalOrigin;
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

- (NSArray *)offerDocumentDetail;
@end


