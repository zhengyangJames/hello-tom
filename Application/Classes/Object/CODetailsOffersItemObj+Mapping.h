//
//  CODetailsOffersItemObj+Mapping.h
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsOffersItemObj.h"
#import "CODetailsOffersObj.h"

@interface CODetailsOffersItemObj (Mapping)

- (CODetailsOffersObj*)mappingDetailsOffersItemAddress:(NSDictionary*)dicObj;
- (CODetailsOffersObj*)mappingDetailsOffersItemTitle:(NSDictionary*)dicObj;
- (CODetailsOffersObj*)mappingDetailsOffersItemDescription:(NSDictionary*)dicObj;
- (CODetailsOffersObj*)mappingDetailsOffersItemProjectDesc:(NSDictionary*)dicObj;
- (CODetailsOffersObj*)mappingDetailsOffersItemDocument;
- (CODetailsOffersObj*)mappingDetailsOffersItemSubDocument:(NSDictionary*)arrayObj andKey:(NSString*)key;

@end
