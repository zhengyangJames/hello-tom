//
//  COProjectDetailModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@class COOfferModel;
@class CODocumentModel;

@interface COProjectDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *detailInvestorCount;
@property (nonatomic, strong) NSString *detailAnnualReturn;
@property (nonatomic, strong) NSString *detailStatus;
@property (nonatomic, strong) NSString *detailCompanyLogo;
@property (nonatomic, strong) CODocumentModel *detailDocuments;
@property (nonatomic, strong) NSString *detailAnnualizedReturn;
@property (nonatomic, strong) NSString *detailDayLeft;
@property (nonatomic, strong) NSString *detailDeveloperName;
@property (nonatomic, strong) NSString *detailDeveloperDescription;
@property (nonatomic, strong) NSString *detailProjectDescription;
@property (nonatomic, strong) NSString *detailHowToCrowdFundPic;
@property (nonatomic, strong) NSString *detailHighlight;
@property (nonatomic, strong) NSString *detailDescription;

@end
