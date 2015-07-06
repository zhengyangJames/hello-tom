//
//  CODetailsProjectBottomTVCell.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectBottomTVCell.h"
#import "WSURLSessionManager+ListHome.h"

@implementation CODetailsProjectBottomTVCell

#pragma mark - Action



- (IBAction)__actionInterested:(id)sender {
    [UIHelper showLoadingInView:self.superview];
    NSString *idoffer = [self.object valueForKey:@"id"];
    NSString *amount = [[self.object valueForKey:@"amount"] stringValue];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:amount,@"amount", nil];
    [[WSURLSessionManager shared] wsPostSubscribeWithOffersID:idoffer amount:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        DBG(@"%@",responseObject);
        [UIHelper hideLoadingFromView:self.superview];
    }];
}

- (IBAction)__actionQuestions:(id)sender {
    [UIHelper showLoadingInView:self.superview];
    NSString *idoffer = [self.object valueForKey:@"id"];
    [[WSURLSessionManager shared] wsPostQuestionWithOffersID:idoffer handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        DBG(@"--%@--",responseObject);
        [UIHelper hideLoadingFromView:self.superview];
    }];
}

@end
