//
//  PortFolioCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "PortfolioCell.h"

@interface PortfolioCell ()
{
    __weak IBOutlet UIImageView *_imgThumbnail1;
    __weak IBOutlet UILabel *_lbNameDetail1;
    __weak IBOutlet UILabel *_lbNumOfValue1;
    
    __weak IBOutlet UIImageView *_imgThumbnail2;
    __weak IBOutlet UILabel *_lbNameDetail2;
    __weak IBOutlet UILabel *_lbNumOfValue2;
}
@end

@implementation PortfolioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void)setMultiPortlio:(COMultiPortFolioModel *)multiPortlio {
    _multiPortlio = multiPortlio;
    if (self.indexPath) {
        if (self.indexPath.row ==0) {
            [self _setDataWhenIndexPathIs0:multiPortlio];
        } else {
            [self _setDataWhenIndexPathIs1:multiPortlio];
        }
    }
}

#pragma mark - Private
- (void)_setDataWhenIndexPathIs0:(COMultiPortFolioModel *)multiPortlio {
    [_imgThumbnail1 setImage:[UIImage imageNamed:[multiPortlio OngoingProjectsImage]]];
    _lbNameDetail1.text = [multiPortlio OngoingProjectsTitle];
    _lbNumOfValue1.text = [[multiPortlio ongoingProject] stringValue];
    
    [_imgThumbnail2 setImage:[UIImage imageNamed:[multiPortlio COOngoingInvestmentImage]]];
    _lbNameDetail2.text = [multiPortlio COOngoingInvestmentTitle];
    _lbNumOfValue2.text = [self _getStringFromDictionary:[multiPortlio ongoingInvestment]];
}

- (void)_setDataWhenIndexPathIs1:(COMultiPortFolioModel *)multiPortlio {
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortlio COCompletedProjectsTitle];
    _lbNumOfValue1.text = [[multiPortlio completeProject] stringValue];
    
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortlio COCompletedInvestmentTitle];
    _lbNumOfValue2.text = [self _getStringFromDictionary:[multiPortlio completeInvestment]];
}

- (NSString *)_getStringFromDictionary:(NSDictionary *)dic {
    NSString *strText = [[NSString alloc]init];
    for (NSString *key in [dic allKeys]) {
        NSString *content = [[NSString alloc] init];
        NSString *str = [UIHelper formartFoatValueWithPortfolio:[dic objectForKey:key]];
        
        if ([str isEqualToString:@"N/A"]) {
            content = str;
        } else {
            content = [key stringByAppendingFormat:@"%@%@",@"-",str];
        }
        if (strText.isEmpty == false) {
            strText = [strText stringByAppendingFormat:@"\n%@",content];
        } else {
            strText = content;
        }
    }
    return strText;
}

@end
