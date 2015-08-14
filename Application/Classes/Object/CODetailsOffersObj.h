//
//  CODetailsOffersObj.h
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CODetailsOffersItemObj.h"
#import "CODetailsProfileObj.h"

@interface CODetailsOffersObj : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *offerItemObjs;
- (void)setDetailsOffersItemObj:(id)obj type:(NSString*)type ;
- (void)setDetailsOffersItemProfileObj:(CODetailsProfileObj*)obj type:(NSString *)type;
- (void)setDetailsOffersItemDocument:(NSArray*)obj type:(NSString *)type;
@end
