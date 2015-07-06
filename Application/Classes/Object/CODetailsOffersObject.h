//
//  CODetailsOffersObject.h
//  CoAssets
//
//  Created by TUONG DANG on 7/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CODetailsOffersObject : NSObject

@property (strong, nonatomic) NSString *offerID;
@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *imageSmall;
@property (strong, nonatomic) NSString *imageBig;
@property (strong, nonatomic) NSString *detailsShort;
@property (strong, nonatomic) NSString *offersDetails;
@property (strong, nonatomic) NSString *projectDetails;
@property (strong, nonatomic) NSString *documentDetails;
@property (strong, nonatomic) NSString *declarationform;
@property (strong, nonatomic) NSString *otherDocument;
@property (strong, nonatomic) NSString *companyRegistration;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *region_state;
@property (strong, nonatomic) NSString *country;

@property (strong, nonatomic) NSString *projectType;
@property (strong, nonatomic) NSString *projectDeveloper;
@property (strong, nonatomic) NSString *projectSite;
@property (strong, nonatomic) NSString *projectStatus;
@property (strong, nonatomic) NSString *projectInterested;
@property (strong, nonatomic) NSString *projectInvestertment;

- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end
