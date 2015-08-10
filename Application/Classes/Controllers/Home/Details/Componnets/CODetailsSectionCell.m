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
        title = NSLocalizedString(@"SECTION_DECLARATION_FORM", nil);
    } else if ([string isEqualToString:@"legal_appointment"]) {
        title = NSLocalizedString(@"SECTION_LEGAL_APPOINTMENT", nil);
    } if ([string isEqualToString:@"licenses"]) {
        title = NSLocalizedString(@"SECTION_PROOF_OF_LICENSES", nil);
    } else if ([string isEqualToString:@"others"]) {
        title = NSLocalizedString(@"SECTION_OTHER_DOCUMENTS", nil);
    }if ([string isEqualToString:@"ownership"]) {
        title = NSLocalizedString(@"SECTION_PROOF_OF_OWNERSHIP", nil);
    } else if ([string isEqualToString:@"registration_form_list"]) {
        title = NSLocalizedString(@"SECTION_COMPANY_REGISTRATION", nil);
    }
    return title;
}


@end
