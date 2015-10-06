//
//  COUserCompanyModel.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COUserData.h"

@interface COUserCompanyModel : MTLModel<MTLJSONSerializing,COCompanyAdress, COCompanyName, COCompanyImage>

@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *orgName;
@property (strong, nonatomic) NSString *orgType;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *orgCity;
@property (strong, nonatomic) NSString *country;

@end
