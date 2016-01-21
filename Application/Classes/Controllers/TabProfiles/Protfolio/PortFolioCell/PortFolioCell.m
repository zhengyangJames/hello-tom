//
//  PortFolioCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "PortFolioCell.h"

@interface PortFolioCell ()
{
    __weak IBOutlet UIImageView *_imgThumbnail1;
    __weak IBOutlet UILabel *_lbNameDetail1;
    __weak IBOutlet UILabel *_lbNumOfValue1;
    
    __weak IBOutlet UIImageView *_imgThumbnail2;
    __weak IBOutlet UILabel *_lbNameDetail2;
    __weak IBOutlet UILabel *_lbNumOfValue2;
}
@end

@implementation PortFolioCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void)setOngoingInvestment:(NSDictionary *)OngoingInvestment {
    _OngoingInvestment = OngoingInvestment;
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortlio COOngoingInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortlio COOngoingInvestmentTitle];
     _lbNumOfValue2.text = [self getStringFromDictionary:OngoingInvestment];
}

- (void)setOngoingProjects:(NSNumber *)OngoingProjects {
    _OngoingProjects = OngoingProjects;
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortlio OngoingProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortlio OngoingProjectsTitle];
    _lbNumOfValue1.text = [OngoingProjects stringValue];
}

- (void)setCompletedInvestment:(NSDictionary *)CompletedInvestment {
    _CompletedInvestment = CompletedInvestment;
    [_imgThumbnail2 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedInvestmentImage]]];
    _lbNameDetail2.text = [self.multiPortlio COCompletedInvestmentTitle];
    _lbNumOfValue2.text = [self getStringFromDictionary:CompletedInvestment];
}

- (void)setCompletedProjects:(NSNumber *)CompletedProjects {
    _CompletedProjects = CompletedProjects;
    [_imgThumbnail1 setImage:[UIImage imageNamed:[self.multiPortlio COCompletedProjectsImage]]];
    _lbNameDetail1.text = [self.multiPortlio COCompletedProjectsTitle];
    _lbNumOfValue1.text = [CompletedProjects stringValue];
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
