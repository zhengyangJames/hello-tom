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
    __weak IBOutlet UIImageView *_imgThumbnail;
    __weak IBOutlet UILabel *_lbNameDetail;
    __weak IBOutlet UILabel *_lbNumOfValue;
}
@end

@implementation PortFolioCell

- (void)awakeFromNib {
    
}

#pragma mark - Set Get

- (void)setCompletedInvestment:(id<COCompletedInvestment>)CompletedInvestment {
    _CompletedInvestment = CompletedInvestment;
    [_imgThumbnail setImage:[UIImage imageNamed:[_CompletedInvestment COCompletedInvestmentImage]]];
    _lbNameDetail.text = [_CompletedInvestment COCompletedInvestmentTitle];
    
    _lbNumOfValue.text = [self bridgeStringCurrency:@"SGD" str1:[UIHelper formartFoatValueWithPortfolio:[_CompletedInvestment COCompletedInvestmentValue]] currency2:@"MYR" str2:[_CompletedInvestment COCompletedInvestmentDetail]];
}

- (void)setCompletedProjects:(id<COCompletedProjects>)CompletedProjects {
    _CompletedProjects = CompletedProjects;
    [_imgThumbnail setImage:[UIImage imageNamed:[_CompletedProjects COCompletedProjectsImage]]];
    _lbNameDetail.text = [_CompletedProjects COCompletedProjectsTitle];
    _lbNumOfValue.text = [[_CompletedProjects COCompletedProjectsValue] stringValue];
}

- (void)setOngoingInvestment:(id<COOngoingInvestment>)OngoingInvestment {
    _OngoingInvestment = OngoingInvestment;
    [_imgThumbnail setImage:[UIImage imageNamed:[_OngoingInvestment COOngoingInvestmentImage]]];
    _lbNameDetail.text = [_OngoingInvestment COOngoingInvestmentTitle];
    
    _lbNumOfValue.text = [self bridgeStringCurrency:@"SGD" str1:[UIHelper formartFoatValueWithPortfolio:[_OngoingInvestment COOngoingInvestmentValue]] currency2:@"CNY" str2:[_OngoingInvestment COOngoingInvestmentDetail]];
}

- (void)setOngoingProjects:(id<COOngoingProjects>)OngoingProjects {
    _OngoingProjects = OngoingProjects;
    [_imgThumbnail setImage:[UIImage imageNamed:[_OngoingProjects OngoingProjectsImage]]];
    _lbNameDetail.text = [_OngoingProjects OngoingProjectsTitle];
    _lbNumOfValue.text = [[_OngoingProjects OngoingProjectsValue] stringValue];
}

- (NSString *)bridgeStringCurrency:(NSString *)currency1 str1:(NSString *)str1 currency2:(NSString *)currency2 str2:(NSString *)str2 {
    NSString *str = [[NSString alloc]init];
    if ([str1 isEqual:nil]) {
        if ([str2 isEqualToString:@"N/A"]) {
            str = str2;
        } else {
            str = [currency2 stringByAppendingFormat:@"%@ %@", @"-", str2];
        }
        return str;
    } else if ([str2 isEqual:nil]) {
        
        if ([str1 isEqualToString:@"N/A"]) {
            str = str1;
        } else {
            str = [currency1 stringByAppendingFormat:@"%@ %@", @"-", str1];
        }
        return str;
    } else {
        if ([str1 isEqualToString:@"N/A"]) {
            str = [str1 stringByAppendingFormat:@"\n%@%@%@",currency2,@"-", str2];
        } else if([str2 isEqualToString:@"N/A"]) {
            str = [currency1 stringByAppendingFormat:@"%@%@\n%@", @"-", str1, str2];
        } else {
            str = [currency1 stringByAppendingFormat:@"%@%@\n%@%@%@", @"-", str1,currency2,@"-", str2];
        }
        return str;
    }
}

@end
