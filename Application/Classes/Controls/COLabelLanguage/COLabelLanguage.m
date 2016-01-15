//
//  COLabelLanguage.m
//  CoAssets
//
//  Created by Macintosh HD on 1/7/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COLabelLanguage.h"

@implementation COLabelLanguage

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *text = self.text;
    if (![[text trim] isEmpty]) {
        self.text = m_string(text);
    }
}

@end
