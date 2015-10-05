//
//  COUserCompanyModel.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserCompanyModel.h"

@implementation COUserCompanyModel

#pragma mark - company protocol

- (NSString *)companyNameTitle {
    return m_string(@"COMPANY_NAME");
}
- (NSString *)companyNameContent {
    return @"Nikme";
    //return self.companyDetails.companyName;
}

#pragma mark - address1 protocol 

- (NSString *)companyAdressTitle {
    return m_string(@"COMPANY_ADRESS");
}

- (NSString *)companyAdressContent {
    return @"Ngo Thi Nham";
    //return self.companyDetails.companyAdress;
}

#pragma mark - address2 protocol


#pragma mark - image protocol 

- (NSString *)companyImageURL {
    return self.imageUrl;
}

- (void)setCompanyImageURL:(NSString *)imageURL {
    self.imageUrl = imageURL;
}

#pragma mark - orgCity protocol 

#pragma mark - Country protocol 
@end
