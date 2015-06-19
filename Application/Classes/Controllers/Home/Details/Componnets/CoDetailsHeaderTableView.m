//
//  CoDetailsHeaderTableView.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CoDetailsHeaderTableView.h"

@interface CoDetailsHeaderTableView ()
{
    __weak IBOutlet UIImageView *_imageView;
}

@end

@implementation CoDetailsHeaderTableView


#pragma mark - Action 
- (IBAction)__actionBack :(id)sender {
    if (self.actionPopView) {
        self.actionPopView();
    }
}


@end
