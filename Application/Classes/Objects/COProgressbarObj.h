//
//  COProgressbarObj.h
//  CoAssets
//
//  Created by TUONG DANG on 7/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COProgressbarObj : NSObject

@property (nonatomic, strong) NSString *current_funded_amount;
@property (nonatomic, strong) NSString *goal;
- (instancetype)initWithDictionnary:(NSDictionary*)dic;
@end
