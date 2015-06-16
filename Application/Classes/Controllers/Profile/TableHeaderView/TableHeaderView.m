//
//  TableHeaderView.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "TableHeaderView.h"

@interface TableHeaderView () 
{

}
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@end

@implementation TableHeaderView

- (void)viewDidLoad {

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _setCornerRadius];
}

#pragma mark - SetUp UI
- (void)_setupView {
    
}

- (void)_setCornerRadius {
    [_imageProfile.layer setCornerRadius:_imageProfile.bounds.size.height/2];
    _imageProfile.clipsToBounds = YES;

    [self setNeedsDisplay];
}

#pragma mark - Set Get

#pragma mark - Action
- (IBAction)__actionSwitchSegment:(id)sender {
    _segmentControl = (UISegmentedControl*)sender;
    NSInteger indexSegmentSelect = _segmentControl.selectedSegmentIndex;
    switch (indexSegmentSelect) {
        case 0:
        {
            if (self.actionSegment) {
                self.actionSegment(indexSegmentSelect);
            }
        }
            break;
        case 1:
        {
            if (self.actionSegment) {
                self.actionSegment(indexSegmentSelect);
            }
        }
            break;
        case 2:
        {
            if (self.actionSegment) {
                self.actionSegment(indexSegmentSelect);
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Delegate


@end
