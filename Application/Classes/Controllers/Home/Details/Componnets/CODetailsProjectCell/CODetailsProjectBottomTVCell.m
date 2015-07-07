//
//  CODetailsProjectBottomTVCell.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectBottomTVCell.h"
#import "COPositive&NagitiveButton.h"
#import "WSURLSessionManager+ListHome.h"

@interface CODetailsProjectBottomTVCell ()<UIAlertViewDelegate>
{
    __weak IBOutlet COPositive_NagitiveButton *_interedtedBTN;
}

@end

@implementation CODetailsProjectBottomTVCell

#pragma mark - Action

- (void)viewDidLoad {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateButton) name:@"change_titler_button" object:nil];
}


- (IBAction)__actionInterested:(id)sender {

    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:self didSelectAction:CODetailsProjectActionInterested];
    }
}

- (IBAction)__actionQuestions:(id)sender {
    [UIHelper showLoadingInView:self.superview];
    NSString *idoffer = [self.object valueForKey:@"id"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil];
    [[WSURLSessionManager shared] wsPostQuestionWithOffersID:idoffer body:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        DBG(@"--%@--",responseObject);
        [UIHelper hideLoadingFromView:self.superview];
    }];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:m_string(@"CoAssets")
                                                       message:m_string(@"Please type your question below. Email will be sent to coassets admin.")
                                                      delegate:self
                                             cancelButtonTitle:m_string(@"OK")
                                             otherButtonTitles: nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)__actionUpdateButton {
    [_interedtedBTN setTitle:@"I want to invest again!" forState:UIControlStateNormal];
}

#pragma mark - AlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *str = alertView.textInputContextIdentifier;
    DBG(@"%@",str);
}

@end
