//
//  NprofileButtonCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NprofileButtonCell.h"
#import "COPositive&NagitiveButton.h"

@interface NprofileButtonCell ()
{
    __weak IBOutlet COPositive_NagitiveButton *_btnAction;
}
@end

@implementation NprofileButtonCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setActionStyle:(NSInteger)actionStyle {
    _actionStyle = actionStyle;
    NSString *actionName = @"";
    switch (actionStyle) {
        case NProfileActionChangePassWord:
            actionName = m_string(@"KEY_ACTION_UPDATECHANGEPASSWORD");
            break;
        case NProfileActionUpdateProfile:
            actionName = m_string(@"KEY_ACTION_UPDATEPROFILE");
            break;
        case NProfileActionUpdateCompany:
            actionName = m_string(@"KEY_ACTION_UPDATECOMPANY");
            break;
        case NProfileActionUpdateInvestor:
            actionName = m_string(@"KEY_ACTION_UPDATEINVESTOR");
            break;
    }
    [_btnAction setTitle:actionName forState:UIControlStateNormal];
}

@end
