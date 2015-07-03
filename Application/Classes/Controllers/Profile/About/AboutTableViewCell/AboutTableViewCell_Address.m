//
//  AboutTableViewCell_Address.m
//  CoAssets
//
//  Created by TUONG DANG on 7/3/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AboutTableViewCell_Address.h"

@interface AboutTableViewCell_Address ()
{
    __weak IBOutlet UITextView *address;
}

@end

@implementation AboutTableViewCell_Address

- (void)viewDidLoad {
    
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setString:(NSString *)string {
    _string = string;
    address.text = _string;
//    [address setNeedsUpdateConstraints];
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
}

@end
