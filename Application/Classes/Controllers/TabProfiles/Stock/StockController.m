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
    __weak IBOutlet UIButton *_btnCode;
    __weak IBOutlet UIButton *_btnCurrency;
    __weak IBOutlet UIButton *_btnPrice;
    __weak IBOutlet UIButton *_btnlDate;
    __weak IBOutlet COPositive_NagitiveButton *_btnInterest;
    __weak IBOutlet UIView *_viewHeader;
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
        [_btnCode setTitle:[self.stockModel stringOfCode] forState:UIControlStateNormal];
        [_btnCurrency setTitle:[self.stockModel stringOfCurrency] forState:UIControlStateNormal];
        [_btnPrice setTitle:[[self.stockModel numberOfPrice] stringValue] forState:UIControlStateNormal];
        [_btnlDate setTitle:[UIHelper formatDateStock:[self.stockModel stringOfPriceDate]] forState:UIControlStateNormal];
    }
}

#pragma mark: Action
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
        _viewHeader.hidden = true;
    }
    
    //    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsGetStockProfileRequestHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && (responseObject != nil)) {
            [UIHelper hideLoadingIndicator];
            [UIHelper hideLoadingFromView:self.view];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.stockModel = nil;
                [COLoginManager shared].stockModel = nil;
                [self loadData];
                _viewHeader.hidden = false;
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingIndicator];
            [UIHelper hideLoadingFromView:self.view];
        }
    }];
}

@end
