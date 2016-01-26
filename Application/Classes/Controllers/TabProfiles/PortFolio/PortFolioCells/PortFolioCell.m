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
- (void)setMultiPortfolio:(COMultiPortfolioModel *)multiPortfolio  {
    _multiPortfolio = multiPortfolio;
    if (self.indexPath) {
        if (self.indexPath.row ==0) {
            [self _setDataWhenIndexPathIs0:multiPortfolio];
        } else {
            [self _setDataWhenIndexPathIs1:multiPortfolio];
        }
    }
}

#pragma mark - Private
- (void)_setDataWhenIndexPathIs0:(COMultiPortfolioModel *)multiPortfolio {
    [_imgThumbnail1 setImage:[UIImage imageNamed:[multiPortfolio OngoingProjectsImage]]];
    _lbNameDetail1.text = [multiPortfolio OngoingProjectsTitle];
    _lbNumOfValue1.text = [[multiPortfolio ongoingProject] stringValue];
    
    [_imgThumbnail2 setImage:[UIImage imageNamed:[multiPortfolio COOngoingInvestmentImage]]];
    _lbNameDetail2.text = [multiPortfolio COOngoingInvestmentTitle];
    _lbNumOfValue2.text = [self _getStringFromDictionary:[multiPortfolio ongoingInvestment]];
}

- (void)_setDataWhenIndexPathIs1:(COMultiPortfolioModel *)multiPortfolio {
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortfolio COCompletedProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortfolio COCompletedProjectsTitle];
    _lbNumOfValue1.text = [[multiPortfolio completeProject] stringValue];
    
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortfolio COCompletedInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortfolio COCompletedInvestmentTitle];
    _lbNumOfValue2.text = [self _getStringFromDictionary:[multiPortfolio completeInvestment]];
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
