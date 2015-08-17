//
//  COProjectDetailModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProjectDetailModel.h"
#import "CODocumentModel.h"

@implementation COProjectDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"detailInvestorCount" : @"investor_count",
        @"detailAnnualReturn" : @"annual_return",
        @"detailStatus" : @"status",
        @"detailCompanyLogo" : @"company_logo",
        @"detailDocuments" : @"documents",
        @"detailAnnualizedReturn" : @"annualized_return",
        @"detailDayLeft" : @"day_left",
        @"detailDeveloperName" : @"developer_name",
        @"detailDeveloperDescription" : @"developer_description",
        @"detailProjectDescription" : @"project_description",
        @"detailHowToCrowdFundPic" : @"how_to_crowd_fund_pic",
        @"detailHighlight" : @"highlight",
        @"detailDescription" : @"description",
        
    };
}

+ (NSValueTransformer *)detailDocumentsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CODocumentModel.class];
}


@end
