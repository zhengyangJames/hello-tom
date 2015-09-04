//
//  WSPostQuestionRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSPostQuestionRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSPostQuestionRequest

- (void)setValueWithModel:(id)model {
    COUserProfileModel *userModel = model;
    NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    [self setValue:value forHTTPHeaderField:@"Authorization"];
}
@end
