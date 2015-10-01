//
//  COUserCompanyModel.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserCompanyModel.h"

@implementation COUserCompanyModel

- (NSString *)companyNameTitle {
    return m_string(@"COMPANY_NAME");
}
- (NSString *)companyNameContent {
    return @"Nikme";
    //return self.companyDetails.companyName;
}

- (NSString *)companyAdressTitle {
    return m_string(@"COMPANY_ADRESS");
}

- (NSString *)companyAdressContent {
    return @"Ngo Thi Nham";
    //return self.companyDetails.companyAdress;
}

- (NSURL *)companyImageURL {
   // return self.companyDetails.companyURL;
    return nil;
}

@end
