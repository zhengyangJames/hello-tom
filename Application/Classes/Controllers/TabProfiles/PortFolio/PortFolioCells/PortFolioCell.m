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
- (void)setOngoingInvestment:(NSDictionary *)ongoingInvestment {
    _ongoingInvestment = ongoingInvestment;
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortlio COOngoingInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortlio COOngoingInvestmentTitle];
    _lbNumOfValue2.text = [self getStringFromDictionary:ongoingInvestment];
}

- (void)setOngoingProjects:(NSNumber *)ongoingProjects {
    _ongoingProjects = ongoingProjects;
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortlio OngoingProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortlio OngoingProjectsTitle];
    _lbNumOfValue1.text = [ongoingProjects stringValue];
}

- (void)setCompletedInvestment:(NSDictionary *)completedInvestment {
    _completedInvestment = completedInvestment;
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortlio COCompletedInvestmentTitle];
    _lbNumOfValue2.text = [self getStringFromDictionary:completedInvestment];
}

- (void)setCompletedProjects:(NSNumber *)completedProjects {
    _completedProjects = completedProjects;
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortlio COCompletedProjectsTitle];
    _lbNumOfValue1.text = [completedProjects stringValue];
}

- (NSString *)getStringFromDictionary:(NSDictionary *)dic {
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
