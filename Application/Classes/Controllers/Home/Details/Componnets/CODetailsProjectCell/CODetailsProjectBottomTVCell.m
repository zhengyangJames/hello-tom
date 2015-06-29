//
//  CODetailsProjectBottomTVCell.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectBottomTVCell.h"

@implementation CODetailsProjectBottomTVCell

- (void)viewDidLoad {
    
}


#pragma mark - Action

- (IBAction)__actionInterested:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:sender didSelectAction:CODetailsProjectActionInterested];
    }

}

- (IBAction)__actionQuestions:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:sender didSelectAction:CODetailsProjectActionQuestions];
    }
}

@end
