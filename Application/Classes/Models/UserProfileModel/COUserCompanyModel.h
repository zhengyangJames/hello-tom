//
//  COUserCompanyModel.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "MTLModel.h"
#import "COUserData.h"

@interface COUserCompanyModel : MTLModel<COCompanyAdress, COCompanyName, COCompanyImage>

@property (nonatomic, strong) NSString *imageUrl;
@property (strong, nonatomic) NSString *orgName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *orgCity;
@property (strong, nonatomic) NSString *country;

@end
