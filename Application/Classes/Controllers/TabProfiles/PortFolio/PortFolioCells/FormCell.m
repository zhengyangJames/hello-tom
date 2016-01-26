//
//  FormCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "FormCell.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"
#import "COLoginManager.h"
#import "COBalanceModel.h"

@interface FormCell() {
    __weak IBOutlet CoDropListButtom *_btnDrop;
    __weak IBOutlet UITextField *_tfAmount;
    
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *arrCurrencyName;

@end

@implementation FormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnDrop.layer.cornerRadius = 4;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - setter, getter
- (void)setArrayAvailableBalance:(NSArray *)arrayAvailableBalance {
    _arrayAvailableBalance = arrayAvailableBalance;
    self.arrCurrencyName = nil;
    COBalanceModel *balanceModel = [arrayAvailableBalance objectAtIndex:self.index];
    [_btnDrop setTitle:[balanceModel currency] forState:UIControlStateNormal];
}

- (NSMutableArray *)arrCurrencyName {
    if (_arrCurrencyName) {
        return _arrCurrencyName;
    }
    _arrCurrencyName = [[NSMutableArray alloc] init];
    for (COBalanceModel *balanceModel in self.arrayAvailableBalance) {
        NSString *currencyName = [balanceModel currencyName];
        [_arrCurrencyName addObject:currencyName];
    }
    return _arrCurrencyName;
}

- (NSInteger )index {
    NSNumber *indexNumber = [kUserDefaults objectForKey:UPDATE_CURRENCY];
    if (indexNumber) {
        return [indexNumber integerValue];
    }
    return 0;
}

#pragma mark - Private
- (void)_showAlertView:(NSString *)message {
    [UIHelper showAlertViewWithTitle:m_string(m_string(@"APP_NAME")) message:message cancelButton:@"OK" delegate:self tag:1 arrayTitleButton: nil];
}

#pragma mark - Action
- (IBAction)__actionInvestor:(id)sender {
    [self endEditing:NO];
    [CODropListView presentWithTitle:@"Currency" data:self.arrCurrencyName selectedIndex:self.index didSelect:^(NSInteger index) {
        [kUserDefaults setObject:[NSNumber numberWithInteger:index] forKey:UPDATE_CURRENCY];
        [kUserDefaults synchronize];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            COBalanceModel *balanceModel = [self.arrayAvailableBalance objectAtIndex:self.index];
            [_btnDrop setTitle:[balanceModel currency] forState:UIControlStateNormal];
        }];
    }];
}

- (IBAction)__actionWithDraw:(id)sender {
    COBalanceModel *balanceModel = [self.arrayAvailableBalance objectAtIndex:self.index];
    NSNumber *number = balanceModel.balance_amt;
    
    if (_tfAmount.text.isEmpty == false) {
        BOOL doubleValid = [UIHelper isStringDecimalNumber:_tfAmount.text];
        if ( doubleValid) {
            if ([_tfAmount.text doubleValue] <= [number doubleValue]) {
                [self _checkconditionSuccess];
            } else {
                NSString *message = [NSString stringWithFormat:@"%@ %@",m_string(@"MESSAGE_TEXTFIELD_MAX_AMOUNT"), [number stringValue]];
                [self _showAlertView:message];
            }
        } else {
            [self _showAlertView:m_string(@"MESSAGE_TEXTFIELD_VALI")];
        }
        
    } else {
        [self _showAlertView:m_string(@"MESSAGE_TEXTFIELD_NULL")];
    }
}

- (void)_checkconditionSuccess {
    DBG(@"OK");
}

@end
