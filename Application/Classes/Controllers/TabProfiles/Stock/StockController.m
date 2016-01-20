//
//  StockController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "StockController.h"
#import <MessageUI/MessageUI.h>
#import "InterstController.h"
#import "WSURLSessionManager+Stock.h"
#import "WSURLSessionManager.h"
#import "COProfileStockModel.h"
#import "COPositive&NagitiveButton.h"
#import "COLoginManager.h"

@interface StockController ()<MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet UILabel *code;
    __weak IBOutlet UILabel *currency;
    __weak IBOutlet UILabel *price;
    __weak IBOutlet UILabel *date;
    __weak IBOutlet COPositive_NagitiveButton *btnInterest;
}

@end

@implementation StockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = m_string(@"STOCK");
    [self callGetStock];
    [self loadData];
}

#pragma mark - Setter, Getter
- (COProfileStockModel *)stockModel {
    if (_stockModel) {
        return _stockModel;
    }
    return _stockModel = [[COLoginManager shared] stockModel];
}

- (void)loadData {
    if (self.stockModel != nil) {
        code.text = [self.stockModel stringOfCode];
        currency.text = [self.stockModel stringOfCurrency];
        price.text = [[self.stockModel numberOfPrice] stringValue];
        date.text = [self.stockModel stringOfPriceDate];
    }
}

- (IBAction)actionInterested:(id)sender {
    InterstController *inter = [[InterstController alloc]init];
    [inter setCallBack:^(NSString *message) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //[btnInterest setTitle:message forState:UIControlStateNormal];
        }];
    }];
    [self.navigationController pushViewController:inter animated:YES];
}

- (void)callGetStock {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsGetStockProfileRequestHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && (responseObject != nil)) {
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.stockModel = nil;
                [self loadData];
                [COLoginManager shared].stockModel = nil;
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
        }
    }];
}

@end
