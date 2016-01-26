//
//  StockController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "StockViewController.h"
#import <MessageUI/MessageUI.h>
#import "InterestViewController.h"
#import "WSURLSessionManager+Stock.h"
#import "WSURLSessionManager.h"
#import "COProfileStockModel.h"
#import "COPositive&NagitiveButton.h"

@interface StockViewController ()<MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIImageView *_imgIcon;
    __weak IBOutlet UIButton *_btnCode;
    __weak IBOutlet UIButton *_btnCurrency;
    __weak IBOutlet UIButton *_btnPrice;
    __weak IBOutlet UIButton *_btnlDate;
    __weak IBOutlet COPositive_NagitiveButton *_btnInterest;
    __weak IBOutlet UIView *_viewHeader;
}
@property (strong, nonatomic) COProfileStockModel *stockModel;

@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = m_string(@"STOCK");
    _viewHeader.hidden = true;
    [self _callAPIGetStock];
    [self _setupData];
}

#pragma mark - Private
- (void)_setupData {
    if (self.stockModel != nil) {
        [_btnCode setTitle:[self.stockModel stringOfCode] forState:UIControlStateNormal];
        [_btnCurrency setTitle:[self.stockModel stringOfCurrency] forState:UIControlStateNormal];
        [_btnPrice setTitle:[[self.stockModel numberOfPrice] stringValue] forState:UIControlStateNormal];
        [_btnlDate setTitle:[UIHelper formatDateStock:[self.stockModel stringOfPriceDate]] forState:UIControlStateNormal];
    }
}

#pragma mark - Action
- (IBAction)__actionInterested:(id)sender {
    InterestViewController *interestVC = [[InterestViewController alloc]initWithNibName:@"InterestViewController" bundle:nil];
    [self.navigationController pushViewController:interestVC animated:YES];
}

#pragma mark - CallAPI
- (void)_callAPIGetStock {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetStockProfileRequestHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.stockModel = responseObject;
                [self _setupData];
                _viewHeader.hidden = false;
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

@end
