//
//  CompletedCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "CompletedCell.h"

@interface CompletedCell()
{
    __weak IBOutlet UILabel *_lblcurrency;
}

@end
@implementation CompletedCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    NSString *_strText;
    for (NSString *key in [dic allKeys]) {
        NSString *str = [UIHelper formartFoatValueWithPortfolio:[dic objectForKey:key]];
        NSString *content = [key stringByAppendingFormat:@"%@%@",@"-",str];
        if (_strText != nil) {
            _strText = [_strText stringByAppendingFormat:@"\n%@",content];
        } else {
            _strText = content;
        }
    }
    _lblcurrency.text = _strText;
}

@end
