//
//  CompletedCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "CompletedCell.h"
#import "COCompleteModel.h"

@interface CompletedCell()
{
    __weak IBOutlet UILabel *_lblcurrency;
    __weak IBOutlet UILabel *_lblTextfooter;
}

@end
@implementation CompletedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lblTextfooter.text = m_string(@"MESSAGE_COMPLETE_PORTPOLIO");
}

#pragma mark - Set Get
- (void)setArrayComplete:(NSArray *)arrayComplete {
    _arrayComplete = arrayComplete;
    NSString *_strText;
    for (COCompleteModel *model in arrayComplete) {
        NSString *key = model.keyComplete;
        NSString *value = [UIHelper formartFoatValueWithPortfolio: model.valueComplete];
        NSString *content = [key stringByAppendingFormat:@"%@%@",@"-",value];
        if (_strText != nil) {
            _strText = [_strText stringByAppendingFormat:@"\n%@",content];
        } else {
            _strText = content;
        }
    }
    _lblcurrency.text = _strText;
}

@end
