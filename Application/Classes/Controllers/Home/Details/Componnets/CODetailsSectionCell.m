//
//  CODetailsSectionCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/19/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsSectionCell.h"

@interface CODetailsSectionCell ()
{
    __weak IBOutlet UILabel *_lblSection;
}

@end

@implementation CODetailsSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}


#pragma mark - Set Get
- (void)setTitleSection:(NSString *)titleSection {
    _titleSection = titleSection;
    _lblSection.text = [self _getTitleWithString:titleSection];
}

- (NSString *)_getTitleWithString:(NSString *)string {
    NSString *title = @"";
    if ([string isEqualToString:@"declaration_form_list"]) {
        title = @"DECLARATION FORM";
    } else if ([string isEqualToString:@"legal_appointment"]) {
        title = @"LEGAL APPOINTMENT";
    } if ([string isEqualToString:@"licenses"]) {
        title = @"PROOF OF LICENSES";
    } else if ([string isEqualToString:@"others"]) {
        title = @"OTHER DOCUMENTS";
    }if ([string isEqualToString:@"ownership"]) {
        title = @"PROOF OF OWNERSHIP";
    } else if ([string isEqualToString:@"registration_form_list"]) {
        title = @"COMPANY REGISTRATION";
    }
    return title;
}


@end
