//
//  COUserCompanyModel.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserCompanyModel.h"

@implementation COUserCompanyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"imageUrl"  : @"imageUrl",
        @"orgName"   : @"orgName",
        @"orgType"   : @"orgType",
        @"address"   : @"address",
        @"address2"  : @"address2",
        @"orgCity"   : @"orgCity",
        @"country"   : @"country",
    };
}

#pragma mark - company protocol

- (NSString *)companyNameTitle {
    return m_string(@"COMPANY_NAME");
}
- (NSString *)companyNameContent {
    if (self.orgName) {
        return @"Nikme Software";
    }
    return m_string(@"NoCompanyAssociated");
}

- (void)setCompanyNameContent:(NSString *)string {
    self.orgName = string;
}

#pragma mark - address protocol

- (NSString *)companyAdressTitle {
    return m_string(@"COMPANY_ADRESS");
}

- (NSString *)companyAdressContent1 {
    return @" 01 Ngo Thi Nham";
}

- (NSString *)companyAdressContent2 {
    return @"100 Nguyen luong bang";
//    return self.address2;
}

- (NSString *)companyOrgtype {
    return @"2";
}

- (NSString *)companyCity {
    return @"Da Nang";
//    return self.orgCity;
}

- (NSString *)companyCountry {
    return @"Viet Nam";
//    return self.country;
}

- (void)setCompanyAdressContent1:(NSString *)string {
    self.address = string;
}

- (void)setCompanyAdressContent2:(NSString *)string {
    self.address2 = string;
}

- (void)setCompanyCity:(NSString *)string {
    self.orgCity = string;
}

- (void)setCompanyOrgtype:(NSString *)string {
    
}

- (void)setCompanyCountry:(NSString *)string {
    self.country = string;
}

#pragma mark - image protocol 

- (NSString *)companyImageURL {
    NSString *url = [[NSURL URLWithString:@"http://www.tapchidanong.org/product_images/h/616/chau-tu-na-3289%284%29__92564_zoom.jpg"] absoluteString];
    return self.imageUrl = url;
}

- (void)setCompanyImageURL:(UIImage *)imageURL {
//    self.imageUrl = imageURL;
}

@end
