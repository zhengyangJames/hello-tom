//
//  NProfileHeaderView.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileHeaderView.h"

@interface NProfileHeaderView ()
{
    __weak IBOutlet UISegmentedControl *_segmentControl;
}
@end

@implementation NProfileHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:15]} forState:UIControlStateNormal];
}

- (IBAction)__actionChangeValueSegment:(id)sender {
    if ([self.delegate respondsToSelector:@selector(nprofileHeaderView:didSelectindex:)]) {
        [self.delegate nprofileHeaderView:self didSelectindex:_segmentControl.selectedSegmentIndex];
    }
}

@end
