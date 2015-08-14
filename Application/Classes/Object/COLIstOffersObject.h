//
//  COLIstOffersObject.h
//  CoAssets
//
//  Created by TUONG DANG on 6/24/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COListOffersObject : NSObject

@property (strong, nonatomic) NSString *offerTitle;
@property (strong, nonatomic) NSString *offerPhoto;
@property (strong, nonatomic) NSString *offerCountry;
@property (strong, nonatomic) NSString *offerID;
@property (strong, nonatomic) NSString *offerProjectID;
@property (strong, nonatomic) NSString *offerType;

- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end
