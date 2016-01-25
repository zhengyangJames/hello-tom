//
//  InterstController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "InterestViewController.h"
#import "WSURLSessionManager+Stock.h"
#import "WSURLSessionManager.h"

@interface InterestViewController () {
    __weak IBOutlet UITextView *_tvContent;
}
@end

@implementation InterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

-(void)_setupUI {
    self.title = m_string(@"MESSAGE_TITLE_STOCK");
    _tvContent.text = m_string(@"EMAIL_MESSAGE");
    [self.navigationItem setRightBarButtonItem:[self _doneButtonItem]];
}

- (UIBarButtonItem *)_doneButtonItem {
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(__actionDone)];
    return btnDone;
}

#pragma mark - Private
- (void)_showAlertView:(NSString *)message {
    [UIHelper showAlertViewWithTitle:m_string(m_string(@"TITLE_MESSAGE_STOCK")) message:message cancelButton:@"OK" delegate:self tag:1 arrayTitleButton: nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

#pragma mark - Action
- (void)__actionDone {
    [self _callAPIPostStockProfile];
}

#pragma mark - CallAPI
- (void)_callAPIPostStockProfile {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    NSString *message = [_tvContent.text trim];
    [[WSURLSessionManager shared] wsPostDeviceCompanyProfileTokenRequest: message Handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
        [self _showAlertView:[responseObject objectForKey:@"message"]];
    }];
}

@end
