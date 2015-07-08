//
//  COQuestionView.m
//  CoAssets
//
//  Created by TUONG DANG on 7/8/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COQuestionView.h"
#import "WSURLSessionManager+ListHome.h"

@interface COQuestionView ()
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
}

#pragma mark SetUp UI
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self _setupRightNavigationButton];
}

- (void)_setupRightNavigationButton {
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone)];
    [btBack setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btBack;
}

#pragma mark - Action
- (void)__actionDone {
    [self wsCallQuestion];
}

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [self.view endEditing:YES];
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssets")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

#pragma mark - Web Service
- (void)wsCallQuestion {
    [UIHelper showLoadingInView:self.view];
    NSString *idoffer = [[self.object valueForKey:@"offerID"] stringValue];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textView.text,@"question", nil];
    [[WSURLSessionManager shared] wsPostQuestionWithOffersID:idoffer body:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            DBG(@"--%@--",responseObject);
            [kNotificationCenter postNotificationName:@"change_titler_button_question" object:nil];
            [self _setupShowAleartViewWithTitle:m_string(@"Request sent")];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}


@end
