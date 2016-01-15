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

@interface StockController ()<MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet UILabel *code;
    __weak IBOutlet UILabel *currency;
    __weak IBOutlet UILabel *price;
    __weak IBOutlet UILabel *date;
    __weak IBOutlet COPositive_NagitiveButton *btnInterest;
}

@property (nonatomic, strong) COProfileStockModel *stockModel;

@end

@implementation StockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = m_string(@"STOCK");
    [self callGetStock:^(id responseObject, NSURLResponse *response, NSError *error) {
        
    }];
}

- (void)loadData {
    if (self.stockModel != nil) {
        code.text = [self.stockModel stringOfCode];
        currency.text = [self.stockModel stringOfCurrency];
        price.text = @"0.1";
        date.text = [self.stockModel stringOfPriceDate];
    }
}

- (IBAction)actionSendmail:(id)sender {
    InterstController *inter = [[InterstController alloc]init];
    [inter setCallBack:^(NSString *message) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            [btnInterest setTitle:message forState:UIControlStateNormal];
        }];
    }];
    [self.navigationController pushViewController:inter animated:true];
    
}

- (void)callGetStock:(WSURLSessionHandler)handler {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsGetStockProfileRequestHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && (responseObject != nil)) {
            self.stockModel =  (COProfileStockModel *)responseObject;
            [self loadData];
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
            
        } else {
            [ErrorManager showError:error];
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

@end
