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
    __weak IBOutlet UIImageView *_imgIcon;
    __weak IBOutlet UILabel *_lblCode;
    __weak IBOutlet UILabel *_lblCurrency;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UILabel *_lblDate;
    __weak IBOutlet COPositive_NagitiveButton *_btnInterest;
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
        _lblCode.text = [self.stockModel stringOfCode];
        _lblCurrency.text = [self.stockModel stringOfCurrency];
        _lblPrice.text = [[self.stockModel numberOfPrice] stringValue];
        _lblDate.text = [UIHelper formatDateStock:[self.stockModel stringOfPriceDate]];
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
    if (self.stockModel != nil) {
        [UIHelper showLoadingIndicator];
    } else {
        [UIHelper showLoadingInView:self.view];
    }
    
//    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsGetStockProfileRequestHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && (responseObject != nil)) {
                [UIHelper hideLoadingIndicator];
                [UIHelper hideLoadingFromView:self.view];
          
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.stockModel = nil;
                [self loadData];
                [COLoginManager shared].stockModel = nil;
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingIndicator];
            [UIHelper hideLoadingFromView:self.view];
        }
    }];
}

@end
