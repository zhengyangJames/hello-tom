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
    _lbNumOfValue.text = [UIHelper formartFoatValueWithPortfolio:[_CompletedInvestment COCompletedInvestmentValue]];
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
    _lbNumOfValue.text = [UIHelper formartFoatValueWithPortfolio:[_OngoingInvestment COOngoingInvestmentValue]];
}

- (void)setOngoingProjects:(id<COOngoingProjects>)OngoingProjects {
    _OngoingProjects = OngoingProjects;
    [_imgThumbnail setImage:[UIImage imageNamed:[_OngoingProjects OngoingProjectsImage]]];
    _lbNameDetail.text = [_OngoingProjects OngoingProjectsTitle];
    _lbNumOfValue.text = [[_OngoingProjects OngoingProjectsValue] stringValue];
}

@end
