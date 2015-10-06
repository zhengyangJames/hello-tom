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
        @"imageUrl"  : @"image_profile",
        @"orgName"   : @"org_name",
        @"address"   : @"cp_address_1",
        @"address2"  : @"cp_address_2",
        @"orgCity"   : @"cp_city",
        @"country"   : @"cp_country",
    };
}

#pragma mark - company protocol

- (NSString *)companyNameTitle {
    return m_string(@"COMPANY_NAME");
}
- (NSString *)companyNameContent {
    if ( self.orgName) {
        return self.orgName;
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
    if (self.address) {
        return self.address;
    }
    return nil;
}

- (NSString *)companyAdressContent2 {
    if (self.address2) {
        return self.address2;
    }
    return nil;
}

- (NSString *)companyOrgtype {
    if (self.orgType) {
        return self.orgType;
    }
    return nil;
}

- (NSString *)companyCity {
    if (self.orgCity) {
        return self.orgCity;
    }
    return nil;
}

- (NSString *)companyCountry {
    if (self.country) {
        return self.country;
    }
    return nil;
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
    self.orgType = string;
}

- (void)setCompanyCountry:(NSString *)string {
    self.country = string;
}

#pragma mark - COUserCompany

- (NSInteger)numOfItemInTableview {
    if (!self.imageUrl) {
        if (!self.orgName || !self.orgCity) {
            return NUM_OF_ROW_COMPANY - 2;
        }
        return NUM_OF_ROW_COMPANY - 1;
    } else {
        if (!self.orgName) {
            return NUM_OF_ROW_COMPANY - 1;
        }
        return NUM_OF_ROW_COMPANY;
    }
}

- (NSInteger)indexOfNameCell {
    if (!self.orgName) {
        return NSIntegerMax;
    }
    
    if (!self.imageUrl) {
        return 0;
    }
    return 1;
    
}
- (NSInteger)indexOfAddressCell {
    if (!self.orgCity) {
        return NSIntegerMax;
    }
    if (!self.orgName) {
        return NSIntegerMax;
    }
    
    if (!self.imageUrl) {
        return 1;
    }
    return 2;
}
- (NSInteger)indexOfButtonCell {
    if (!self.imageUrl) {
        if (!self.orgName) {
            return 1;
        } else {
            if (!self.orgCity) {
                return 1;
            } else {
                return 2;
            }
        }
    } else {
        if (!self.orgName) {
            return 2;
        } else {
            if (!self.orgCity) {
                return 2;
            } else {
                return 3;
            }
        }
    }
}
- (NSInteger)indexOfImageCell {
    if (!self.imageUrl) {
        return NSIntegerMax;
    }
    return 0;
    
}
- (NSInteger)indexOfNoDataCell {
    if (self.orgName) {
        return NSIntegerMax;
    }
    
    if (!self.imageUrl) {
        return 0;
    }
    return 1;
}

#pragma mark - image protocol

- (NSString *)companyImageURL {
    if (self.imageUrl) {
        return self.imageUrl;
    }
    return nil;
}

- (void)setCompanyImageURL:(NSString *)imageURL {
    self.imageUrl = imageURL;
}

@end
