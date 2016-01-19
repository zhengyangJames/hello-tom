//
//  InterstController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "InterstController.h"
#import "WSURLSessionManager+Stock.h"
#import "WSURLSessionManager.h"

@interface InterstController () {
    __weak IBOutlet UITextView *tvContent;
}

@end

@implementation InterstController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI {
    self.title = m_string(@"STOCK");
    tvContent.text = m_string(@"EMAIL_MESSAGE");
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(__actionDone)];
    [self.navigationItem setRightBarButtonItem:btnDone];
    
}

- (void)__actionDone {
    
    [self callPostStockProfileHandler];
}

- (void)callPostStockProfileHandler {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsPostDeviceCompanyProfileTokenRequest: tvContent.text Handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
        [self showAlertView:[responseObject objectForKey:@"message"]];
    }];
}

- (void)showAlertView:(NSString *)message {
    [UIHelper showAlertViewWithTitle:m_string(@"APP_NAME") message:message cancelButton:@"OK" delegate:self tag:1 arrayTitleButton: nil];
    if (self.callBack) {
        self.callBack(message);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:true];
    }
}

@end
