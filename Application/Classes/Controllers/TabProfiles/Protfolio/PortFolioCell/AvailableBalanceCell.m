//
//  AvailabelBalanceCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "AvailableBalanceCell.h"

@interface AvailableBalanceCell()
{
    __weak IBOutlet UILabel *_lblConten;
   
}

@end
@implementation AvailableBalanceCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setArrayData:(NSArray *)arrayData{
    _arrayData = arrayData;
     NSString *_strText;
    for (NSDictionary *dic in arrayData) {
        NSString *strCurrency = [dic objectForKey:@"currency"];
        NSString *strBalance = [dic objectForKey:@"balance_amt"];
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
