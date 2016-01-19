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
    
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    NSString *content1 = [dic objectForKey:@"currency"];
    NSString *content2  = [dic objectForKey:@"balance_amt"];
    NSString *content3 = [dic objectForKey:@"updated"];
    _lblConten.text = [content1 stringByAppendingFormat:@"%@%@\n%@",@"-",content2,content3];
}
@end
