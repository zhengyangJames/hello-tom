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
    
    NSString *_strText;
}


@end
@implementation CompletedCell

- (void)awakeFromNib {
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSString *key in [dic allKeys]) {
        NSString *str = [dic objectForKey:key];
        NSString *content = [key stringByAppendingString:str];
        _strText = content;
        [arr addObject:content];
    }
    DBG(@"%@", arr);
    _lblcurrency.text = [_lblcurrency.text stringByAppendingString: _strText];
}

@end
