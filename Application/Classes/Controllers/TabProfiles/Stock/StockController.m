//
//  StockController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "StockController.h"
#import <MessageUI/MessageUI.h>

@interface StockController ()<MFMailComposeViewControllerDelegate>

@end

@implementation StockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = m_string(@"STOCK");
}

- (IBAction)actionSendmail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:m_string(@"EMAIL_SUBJECT")];
        [mail setMessageBody:m_string(@"EMAIL_MESSAGE") isHTML:NO];
        [mail setToRecipients:@[m_string(@"EMAIL_NAME")]];
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
