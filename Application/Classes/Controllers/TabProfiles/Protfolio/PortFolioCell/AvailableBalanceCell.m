//
//  AvailabelBalanceCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "AvailableBalanceCell.h"
#import "COBalanceModel.h"

@interface AvailableBalanceCell()
{
    __weak IBOutlet UILabel *_lblConten;
}

@end
@implementation AvailableBalanceCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void) setArrayAvailableBalances:(NSArray *)arrayAvailableBalances {
    _arrayAvailableBalances = arrayAvailableBalances;
     NSString *_strText;
    
    for (COBalanceModel *balanceModel in arrayAvailableBalances) {
        NSString *strCurrency = balanceModel.currency;
        NSString *strBalance = [UIHelper formartFoatValueWithPortfolio:balanceModel.balance_amt];
        
        NSString *content = [strCurrency stringByAppendingFormat:@"%@%@",@"-",strBalance];
        if (_strText != nil) {
            _strText = [_strText stringByAppendingFormat:@"\n%@",content];
        } else {
            _strText = content;
        }
    }
    _lblConten.text = _strText;
}
@end
