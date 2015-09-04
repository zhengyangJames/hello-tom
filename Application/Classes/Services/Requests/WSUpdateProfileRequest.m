//
//  WSUpdateProfileRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSUpdateProfileRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSUpdateProfileRequest

- (void)setValueWithModel:(id)model {
    COUserProfileModel *userModel = model;
    NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    [self setValue:value forHTTPHeaderField:@"Authorization"];
}

@end
