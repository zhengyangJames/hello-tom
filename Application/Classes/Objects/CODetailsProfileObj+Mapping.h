//
//  CODetailsProfileObj+Mapping.h
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProfileObj.h"
#import "CODetailsOffersObj.h"

@interface CODetailsProfileObj (Mapping)

- (CODetailsOffersObj*)mappingDetailsProfileObjects:(NSDictionary*)ObjDic;

@end
