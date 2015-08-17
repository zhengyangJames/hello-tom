//
//  COProjectDetailModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@class COProjectModel;
@class CODocumentModel;
@class COTextModel;

@interface COProjectDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *detailOwnerType;
@property (nonatomic, strong) NSString *detailOfferType;
@property (nonatomic, strong) NSString *detailOfferTitle;
@property (nonatomic, strong) NSString *detailCompanyLogo;
@property (nonatomic, strong) COProjectModel *detailProject;
@property (nonatomic, strong) NSString *detailStatus;
@property (nonatomic, strong) NSNumber *detailInvestorCount;
@property (nonatomic, strong) NSNumber *detailMinInvestment;
@property (nonatomic, strong) NSNumber *detailTimeHorizon;
@property (nonatomic, strong) NSString *detailAnnualizedReturn;
@property (nonatomic, strong) NSNumber *detailDayLeft;
@property (nonatomic, strong) COTextModel *detailTextOffer;
@property (nonatomic, strong) COTextModel *detailTextProject;
@property (nonatomic, strong) CODocumentModel *detailDocuments;
@property (nonatomic, strong) NSString *detailAddress;

@end
