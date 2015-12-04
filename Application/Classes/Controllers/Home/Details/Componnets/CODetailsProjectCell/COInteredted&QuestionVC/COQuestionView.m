//
//  COQuestionView.m
//  CoAssets
//
//  Created by TUONG DANG on 7/8/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COQuestionView.h"
#import "WSURLSessionManager+ListHome.h"
#import "COLoginManager.h"
#import "WSPostQuestionRequest.h"

@interface COQuestionView ()<UIAlertViewDelegate>
{
    __weak IBOutlet UITextView *textView;
}
@end

@implementation COQuestionView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (![[COLoginManager shared] userModel]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark SetUp UI
- (void)_setupUI {
    self.title = NSLocalizedString(@"QUESTION_TITLE", nil);
    [self _setupRightNavigationButton];
}

- (void)_setupRightNavigationButton {
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"DONE_TITLE", nil)
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone)];
    [btBack setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btBack;
}

- (WSPostQuestionRequest *)_createPostQuestionRequest {
    WSPostQuestionRequest *request = [[WSPostQuestionRequest alloc] init];
    [request setHTTPMethod:METHOD_POST];
    [request setBodyParam:textView.text forKey:kPostQuestion];
    NSString *url = [NSString stringWithFormat:WS_METHOD_POST_QUESTION,[self.offerID stringValue]];
    [request setURL:[NSURL URLWithString:url]];
    [request setValueWithModel:[[COLoginManager shared] userModel]];
    return request;
}
#pragma mark - Action
- (void)__actionDone {
    [self.view endEditing:YES];
    if (![textView.text isEmpty]) {
        [self wsCallQuestion]; return;
    }
    [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"ERROR_QUESTION", nil) delegate:nil tag:1];
}

#pragma mark - Web Service
- (void)wsCallQuestion {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsPostQuestionWithRequest:[self _createPostQuestionRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [kNotificationCenter postNotificationName:kNOTIFICATION_QUESTION object:nil];
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"REQUEST_SEND", nil) delegate:self tag:0];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
