//
//  CODetailsOffersObject.m
//  CoAssets
//
//  Created by TUONG DANG on 7/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsOffersObject.h"

@implementation CODetailsOffersObject

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
//        self.offersDetails = [dic objectForKeyNotNull:@"offer_title"];//
        self.detailsShort = [dic objectForKeyNotNull:@"short_description"];
//        self.projectDetails = [dic objectForKeyNotNull:@"description"];
//        self.documentDetails = [dic objectForKeyNotNull:@"document"];//
//        self.declarationform = [dic objectForKeyNotNull:@"declarationform"];//
//        self.otherDocument = [dic objectForKeyNotNull:@"other_document"];//
//        self.projectInterested = [dic objectForKeyNotNull:@"interested"];
//        self.projectInvestertment = [dic objectForKeyNotNull:@"min_investment"];
//        self.projectSite = [dic objectForKeyNotNull:@"site"];
//        self.projectStatus = [dic objectForKeyNotNull:@"status"];
        NSDictionary *project = [dic objectForKeyNotNull:@"project"];
        self.imageBig = [project objectForKeyNotNull:@"photo"];
        self.address = [project objectForKeyNotNull:@"address_1"];
        self.address2 = [project objectForKeyNotNull:@"address_2"];
        self.city = [project objectForKeyNotNull:@"city"];
        self.region_state = [project objectForKeyNotNull:@"state_region"];
        self.country = [project objectForKeyNotNull:@"country"];
//        self.companyRegistration = [project objectForKeyNotNull:@"country"];
//        self.projectDeveloper = [project objectForKeyNotNull:@"developer"];
        self.projectType = [project objectForKeyNotNull:@"project_type"];
    }
    return self;
}


@end
