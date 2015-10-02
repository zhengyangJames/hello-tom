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

-(instancetype)init {
    self = [super init];
    if (self) {
        COUserProfileModel *userModel = [[COLoginManager shared] userModel];
        
        NSString *headerString = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
        NSDictionary *headers = @{ @"Authorization": headerString };
        [self setAllHTTPHeaderFields:headers];

    }
    return self;
}

@end