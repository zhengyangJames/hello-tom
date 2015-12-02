//
//  WSChangePassWordRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSChangePassWordRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSChangePassWordRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
        if (acc) {
            [self setValue:acc forHTTPHeaderField:@"Authorization"];
        }

    }
    return self;
}

@end